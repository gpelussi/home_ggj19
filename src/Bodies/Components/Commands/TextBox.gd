extends "Command.gd"

export(String, MULTILINE) var dialogue_text = ""

func action():
	run_recursive = false
	textbox.run_dialogue(dialogue_text)
	yield(textbox, "dialogue_finished")
	emit_signal("command_done")

