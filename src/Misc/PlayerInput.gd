extends Node

var player

func register_player(body):
	player = body

func deregister_player(body):
	player = null

func lock_input():
	if player and player.has_node("Controls"):
		player.get_node("Controls").disable_action()

func unlock_input():
	if player and player.has_node("Controls"):
		player.get_node("Controls").enable_action()

func fanfare():
	if player:
		player.fanfare()

func stop():
	if player:
		player.stop()
