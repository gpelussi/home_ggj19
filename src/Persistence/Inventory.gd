extends "res://Persistence/Persistence.gd"

signal item_awarded
signal item_given

const NPC_INDEX_STRING = "%s_%s"

func gain_item(item):
	set_data(item, true)
	emit_signal("item_awarded", item)

func lose_item(item):
	set_data(item, false)
	emit_signal("item_given", item)

func has_item(item):
	return get_data(item)

func npc_has_item(npc, item):
	var npc_text = NPC_INDEX_STRING % [npc, item]
	return get_data(npc_text, false)
	
func npc_gain_item(npc, item):
	var npc_text = NPC_INDEX_STRING % [npc, item]
	set_data(npc_text, true)
