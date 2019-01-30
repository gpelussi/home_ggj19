extends "Command.gd"

export(String) var item_to_give = ""

func action():
	assert(not item_to_give.empty())
	inventory.gain_item(item_to_give)
	animate_fanfare(item_to_give)

func animate_fanfare(item):
	player_input.stop()
	player_input.fanfare()
	textbox.run_dialogue("You gained [%s]!" % item)
	yield(textbox, "dialogue_finished")
	player_input.stop()
	finish()