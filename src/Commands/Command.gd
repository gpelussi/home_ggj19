extends Node

signal command_done

onready var database = get_node("/root/Database")
onready var inventory = get_node("/root/Inventory")
onready var textbox = get_node("/root/Hud/TextBox")
onready var player_input = get_node("/root/PlayerInput")
onready var screen_screamer = get_node("/root/ScreenScreamer")

var force_quit = false
var idx = 0

func action():
	pass

func run():
	print("Running [%s]" % self.name)
	force_quit = false
	idx = 0
	action()

func run_all():
	if force_quit:
		return
	if idx >= get_child_count():
		finish()
		return
	var command = get_child(idx)
	print("Connecting [%s] to [%s]" % [command.name, self.name])
	command.connect("command_done", self, "next", [], CONNECT_ONESHOT)
	yield(get_tree(), "idle_frame")
	command.run()

func next():
	print("Disconnecting [%s] from [%s]" % [get_child(idx).name, self.name])
	idx += 1
	run_all()

func finish():
	print("Finishing [%s]" % self.name)
	force_quit = true
	emit_signal("command_done")
