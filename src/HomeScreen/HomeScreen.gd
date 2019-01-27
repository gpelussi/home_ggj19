extends Node2D

const DESERTIA = preload("res://Maps/Desert_Map.tscn")
const FURRIA = preload("res://Maps/Earth_Map.tscn")
const FREEZIA = preload("res://Maps/Ice_Map.tscn")

onready var open_animation_player = get_node("Title/AnimationPlayer")
onready var press_start_animation_player = get_node("Label/AnimationPlayer")
onready var tween = get_node("Tween")
onready var root = get_tree().get_root()

func _ready():
	set_process_input(false)
	yield(open_animation_player, "animation_finished")
	press_start_animation_player.play("Auto")
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ACTION_CONFIRM"):
		start_game(DESERTIA)

func start_game(world):
		var loading_screen = get_node("/root/LoadingScreen")
		loading_screen.fade_out(0.5)
		yield(loading_screen, "faded_out")
		root.add_child(world.instance())
		hide()
		loading_screen.fade_in(0.5)
		yield(loading_screen, "faded_in")
		queue_free()
