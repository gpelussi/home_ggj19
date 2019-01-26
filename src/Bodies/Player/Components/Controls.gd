extends Node

const Physics = preload("res://Bodies/Physics.gd")

var active = true

func _physics_process(delta):
	if active:
		if Input.is_action_pressed("DIR_RIGHT"):
			get_parent().move_right()
		if Input.is_action_pressed("DIR_LEFT"):
			get_parent().move_left()

func _input(event):
	if active:
		if event.is_action_pressed("ACTION_A"):
			print("CONFIRM")
		elif event.is_action_pressed("ACTION_B"):
			print("CANCEL")
		elif event.is_action_pressed("ACTION_C"):
			get_parent().jump()
		elif event.is_action_pressed("ACTION_D"):
			print("AUX")
		elif event.is_action_pressed("ACTION_PAUSE"):
			print("PAUSE")
