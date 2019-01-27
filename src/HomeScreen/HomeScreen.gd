extends "res://Screen.gd"

const DESERTIA = "res://Maps/Desert_Map.tscn"
const FURRIA = "res://Maps/Earth_Map.tscn"
const FREEZIA = "res://Maps/Ice_Map.tscn"

onready var title = get_node("Title")
onready var open_animation_player = get_node("Title/AnimationPlayer")
onready var press_start_animation_player = get_node("Label/AnimationPlayer")
onready var screen_screamer = get_node("/root/ScreenScreamer")
onready var label = get_node("Label")
onready var root = get_tree().get_root()

var choosing_planet = false
var planet = 0
var planet_names =["DesertCompass","FreezeCompass","EarthCompass"] 

func _ready():
	for planetstring in planet_names:
		get_node(planetstring).hide()
	get_node("DesertCompass").show()
	set_process_input(false)
	yield(open_animation_player, "animation_finished")
	press_start_animation_player.play("Auto")
	set_process_input(true)

func _input(event):
	if choosing_planet:
		if event.is_action_pressed("ACTION_CONFIRM"):
				match planet: 
					0:
						start_game(DESERTIA)
					1:
						start_game(FREEZIA)
					2:
						start_game(FURRIA)
		if event.is_action_pressed("DIR_RIGHT"):
			planet = (planet + 1) % 3
			update_cursor()
		if event.is_action_pressed("DIR_LEFT"):
			planet = (planet - 1) % 3
			update_cursor()
	else:
		if event.is_action_pressed("ACTION_CONFIRM"):
			choosing_planet = true
			update_cursor()
			title.hide()
			label.hide()
			press_start_animation_player.stop()
func start_game(world):
		set_process_input(false)
		screen_screamer.set_screen(world)

func update_cursor():
	for planetstring in planet_names:
		get_node(planetstring).hide()
	get_node(planet_names[planet]).show()