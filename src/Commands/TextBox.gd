extends "Command.gd"

export(String, MULTILINE) var dialogue_text = ""

func action():
	textbox.run_dialogue(dialogue_text)
	yield(textbox, "dialogue_finished")
	finish()
