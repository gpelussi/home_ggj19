extends Node

signal set_screen

onready var loading_screen = get_node("/root/LoadingScreen")

var current_screen

func register_screen(screen):
	current_screen = screen

func set_screen(screen_path):
	loading_screen.fade_out(0.5)
	yield(loading_screen, "faded_out")
	if current_screen:
		current_screen.queue_free()
	print(screen_path)
	var screen_scene = load(screen_path)
	current_screen = screen_scene.instance()
	get_node("/root").add_child(current_screen)
	emit_signal("set_screen", screen_path)
	loading_screen.fade_in(0.5)
	yield(loading_screen, "faded_in")
