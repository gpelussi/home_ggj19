extends "res://Persistence/Persistence.gd"

signal item_awarded
signal item_given

const NPC_INDEX_STRING = "%s_talk_index"

func gain_item(item):
	set_data(item, true)
	emit_signal("item_awarded", item)

func lose_item(item):
	set_data(item, false)
	emit_signal("item_given", item)

func has_item(item):
	return get_data(item)

func increase_npc_text(npc):
	var npc_text = NPC_INDEX_STRING % npc
	set_data(npc_text, get_data(npc_text, 0) + 1)

func get_npc_text(npc):
	var npc_text = NPC_INDEX_STRING % npc
	return get_data(npc_text, 0)
