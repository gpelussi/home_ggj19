extends Node

signal command_done

onready var database = get_node("/root/Database")
onready var inventory = get_node("/root/Inventory")
onready var textbox = get_node("/root/Hud/TextBox")
onready var player_input = get_node("/root/PlayerInput")
onready var screen_screamer = get_node("/root/ScreenScreamer")


var run_recursive = true

func action():
	pass

func run():
	print("running %s" % get_name())
	action()
	if not run_recursive:
		return emit_signal("command_done")
	print("action done, running recursively")
	for child in get_children():
		child.run()
		yield(child, "command_done")
	emit_signal("command_done")
