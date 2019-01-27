extends "res://Bodies/Components/Commands/Command.gd"

export(String, FILE) var screen_path

func action():
	screen_screamer.set_screen(screen_path)
	run_recursive = false
	emit_signal("command_done")
