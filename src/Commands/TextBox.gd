extends "Command.gd"

export(String, MULTILINE) var dialogue_text = ""

func action():
	print("Started Dialogue")
	textbox.run_dialogue(dialogue_text)
	yield(textbox, "dialogue_finished")
	print("Finished Dialogue")
	finish()
