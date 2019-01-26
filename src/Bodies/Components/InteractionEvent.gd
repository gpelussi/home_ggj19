extends Node

signal trigger_text

onready var database = get_node("/root/Database")
onready var inventory = get_node("/root/Inventory")

export(String) var first_needed_item = ""
export(String) var second_needed_item = ""

export(String, MULTILINE) var text_default = "Default Text"
export(String, MULTILINE) var text_alt_1 = ""
export(String, MULTILINE) var text_alt_2 = ""

export(String) var item_given_on_first_text = ""
export(String) var item_given_on_second_text = ""
export(String) var item_given_on_third_text = ""

var needed_items = []
var given_items = {}
var texts = []

func _ready():
	# needed items
	if not first_needed_item.empty():
		needed_items.append(first_needed_item)
		if not second_needed_item.empty(): 
			needed_items.append(second_needed_item)
	# given items
	if not item_given_on_first_text.empty():
		given_items[item_given_on_first_text] = true
	if not item_given_on_second_text.empty(): 
		given_items[item_given_on_second_text] = true
	if not item_given_on_third_text.empty(): 
		given_items[item_given_on_third_text] = true
	# dialogue text
	assert(text_default)
	texts.append(text_default)
	if not text_alt_1.empty():
		texts.append(text_alt_1)
		if not text_alt_2.empty():
			texts.append(text_alt_2)

func try_to_trigger():
	var npc_name = get_npc_name()
	var current_text_index = inventory.get_npc_text(npc_name)
	if current_text_index < needed_items.size():
		var needed_item = needed_items[current_text_index]
		if player_has_item(needed_item):
			inventory.lose_item(needed_item)
			inventory.increase_npc_text(npc_name)
	award_item()
	var dialogue_text = get_current_text()
	print(dialogue_text)
	emit_signal("trigger_text", dialogue_text)

func award_item():
	var index = inventory.get_npc_text(get_npc_name())
	match index:
		0:
			if given_items.has(item_given_on_first_text) and given_items[item_given_on_first_text]:
				given_items[item_given_on_first_text] = false
				inventory.gain_item(item_given_on_first_text)
				print("awarding item: %s" % item_given_on_first_text)
		1:
			if given_items.has(item_given_on_second_text) and given_items[item_given_on_second_text]:
				given_items[item_given_on_second_text] = false
				inventory.gain_item(item_given_on_second_text)
				print("awarding item: %s" % item_given_on_second_text)
		2:
			if given_items.has(item_given_on_third_text) and given_items[item_given_on_third_text]:
				given_items[item_given_on_third_text] = false
				inventory.gain_item(item_given_on_third_text)
				print("awarding item: %s" % item_given_on_third_text)

func get_npc_name():
	return get_parent().get_parent().name

# Item checks

func get_current_text():
	var index = inventory.get_npc_text(get_npc_name())
	return texts[index]

func items_are_valid():
	for item in needed_items:
		if not database.item_exists(item):
			return false
	return true
