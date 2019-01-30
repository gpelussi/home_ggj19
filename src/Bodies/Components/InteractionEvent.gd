extends Node

onready var player_input = get_node("/root/PlayerInput")

var current = 0

func try_to_trigger():
	print("Interacting with %s" % get_npc_name())
	player_input.lock_input()
	current = 0
	run_next_command()

func get_npc_name():
	return get_parent().get_parent().name

func run_next_command():
	if current >= get_child_count():
		player_input.unlock_input()
		print("Done interacting with %s" % get_npc_name())
		return
	print("Running next command...")
	var command = get_child(current)
	print("Connecting [%s] to [%s]" % [command.name, self.name])
	command.connect("command_done", self, "next_command", [], CONNECT_ONESHOT)
	yield(get_tree(), "idle_frame")
	command.run()

func next_command():
	print("Diconnecting [%s] from [%s]" % [get_child(current).name, self.name])
	current += 1
	run_next_command()
