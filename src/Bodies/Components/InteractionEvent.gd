extends Node

signal trigger_text

onready var database = get_node("/root/Database")
onready var inventory = get_node("/root/Inventory")

export(PoolStringArray) var items_needed = PoolStringArray()
export(String, MULTILINE) var text_before_giving_item
export(String, MULTILINE) var text_when_item_is_given
export(String, MULTILINE) var text_after_giving_item

func _ready():
	assert(items_are_valid())

func try_to_trigger():
	var text_to_send
	if not i_need_items():
		text_to_send = text_before_giving_item
	else:
		if you_have_them():
			text_to_send = text_when_item_is_given
		elif you_gave_them():
			text_to_send = text_after_giving_item
		else:
			text_to_send = text_before_giving_item
	emit_signal("trigger_text", text_to_send)

# Item checks

func i_need_items():
	return items_needed.size() > 0

func you_have_them():
	for item in items_needed:
		if not inventory.has_item(item):
			return false
	return true

func you_gave_them():
	for item in items_needed:
		if not inventory.gave_item_to(item, get_parent().name):
			return false
	return true

func items_are_valid():
	for item in items_needed:
		if not database.item_exists(item):
			return false
	return true

