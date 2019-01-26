extends Node

var active = true

func _physics_process(delta):
	if active:
		if Input.is_action_pressed("DIR_UP"):
			print("UP")
		elif Input.is_action_pressed("DIR_RIGHT"):
			print("RIGHT")
		elif Input.is_action_pressed("DIR_DOWN"):
			print("DOWN")
		elif Input.is_action_pressed("DIR_LEFT"):
			print("LEFT")

func _input(event):
	if active:
		if event.is_action_pressed("ACTION_A"):
			print("CONFIRM")
		elif event.is_action_pressed("ACTION_B"):
			print("CANCEL")
		elif event.is_action_pressed("ACTION_C"):
			print("JUMP")
		elif event.is_action_pressed("ACTION_D"):
			print("AUX")
		elif event.is_action_pressed("ACTION_PAUSE"):
			print("PAUSE")
