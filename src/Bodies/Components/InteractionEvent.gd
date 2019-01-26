extends Node

signal trigger_text

onready var database = get_node("/root/Database")
onready var inventory = get_node("/root/Inventory")

export(String) var first_needed_item = ""
export(String) var second_needed_item = ""
export(String, MULTILINE) var text_default = "Default Text"
export(String, MULTILINE) var text_alt_1 = ""
export(String, MULTILINE) var text_alt_2 = ""

var needed_items = []
var texts = []

func _ready():
	if not first_needed_item.empty():
		needed_items.append(first_needed_item)
		if not second_needed_item.empty(): 
			needed_items.append(second_needed_item)
	assert(text_default)
	texts.append(text_default)
	if not text_alt_1.empty():
		texts.append(text_alt_1)
		if not text_alt_2.empty():
			texts.append(text_alt_2)
	assert(items_are_valid())

func try_to_trigger():
	var npc_name = get_npc_name()
	var current_text_index = inventory.get_npc_text(npc_name)
	if current_text_index < needed_items.size():
		var needed_item = needed_items[current_text_index]
		if player_has_item(needed_item):
			inventory.lose_item(needed_item)
			inventory.increase_npc_text(npc_name)
	var dialogue_text = get_current_text()
	print(dialogue_text)
	emit_signal("trigger_text", dialogue_text)

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
