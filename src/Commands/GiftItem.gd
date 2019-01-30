extends "Command.gd"

export(String) var item_to_give = ""
export(String) var who_to_give_item_to = ""

func action():
	assert(not item_to_give.empty())
	inventory.lose_item(item_to_give)
	inventory.npc_gain_item(who_to_give_item_to, item_to_give)
	finish()
