extends Node

signal command_done

onready var database = get_node("/root/Database")
onready var inventory = get_node("/root/Inventory")
onready var textbox = get_node("/root/Hud/TextBox")
onready var player_input = get_node("/root/PlayerInput")
onready var screen_screamer = get_node("/root/ScreenScreamer")


var run_recursive = true
var idx = 0

func action():
	pass

func run():
	print("running %s" % get_name())
	action()
	if not run_recursive:
		return
	print("action done, running recursively")
	idx = 0
	next()

func next():
	if idx >= get_child_count():
		emit_signal("command_done")
		return
	var command = get_child(idx)
	idx += 1
	command.connect("command_done", self, "next", [], CONNECT_ONESHOT)
	command.run()
