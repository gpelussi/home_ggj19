extends Node

const Physics = preload("res://Bodies/Physics.gd")

var active = true

func _physics_process(delta):
	var direction = Vector2()
	if active:
		if Input.is_action_pressed("DIR_RIGHT"):
			direction += Physics.RIGHT
		if Input.is_action_pressed("DIR_LEFT"):
			direction += Physics.LEFT
	if direction.length_squared() > 0:
		get_parent().set_movement(direction)

func _input(event):
	if active:
		if event.is_action_pressed("ACTION_A"):
			print("CONFIRM")
		elif event.is_action_pressed("ACTION_B"):
			print("CANCEL")
		elif event.is_action_pressed("ACTION_C"):
			print("JUMP")
			get_parent().jump()
		elif event.is_action_pressed("ACTION_D"):
			print("AUX")
		elif event.is_action_pressed("ACTION_PAUSE"):
			print("PAUSE")
