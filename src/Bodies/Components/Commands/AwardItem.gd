extends "Command.gd"

export(String) var item_to_give = ""

func action():
	assert(not item_to_give.empty())
	inventory.gain_item(item_to_give)
	finish()
