extends Node

signal set_screen

func set_screen(screen_name):
	emit_signal("set_screen", screen_name)
