extends Node

const Physics = preload("res://Bodies/Physics.gd")

onready var textbox = get_node("/root/Hud/TextBox")

var active = true

func _ready():
	textbox.connect("dialogue_started", self, "disable_action")
	textbox.connect("dialogue_finished", self, "enable_action")

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
			
func enable_action():
	active = true

func disable_action():
	active = false
