extends "Command.gd"

export(String) var item_to_give = ""

func action():
	assert(not item_to_give.empty())
	run_recursive = false
	inventory.gain_item(item_to_give)
	emit_signal("command_done")
