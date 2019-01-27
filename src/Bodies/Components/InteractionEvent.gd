extends Node

onready var player_input = get_node("/root/PlayerInput")

var current = 0

func try_to_trigger():
	print("interact with %s" % get_parent().get_parent().name)
	player_input.lock_input()
	current = 0
	run_next_command()

func get_npc_name():
	return get_parent().get_parent().name

func run_next_command():
	var commands = get_children()
	if current >= get_child_count():
		player_input.unlock_input()
		print("commands done")
		return
	var command = get_child(current)
	command.connect("command_done", self, "next_command", [], CONNECT_ONESHOT)
	command.run()

func next_command():
	current += 1
	run_next_command()