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
		if event.is_action_pressed("ACTION_CONFIRM"):
			if get_parent().has_node("Interaction"):
				get_parent().get_node("Interaction").interact()
		elif event.is_action_pressed("ACTION_JUMP"):
			get_parent().jump()
