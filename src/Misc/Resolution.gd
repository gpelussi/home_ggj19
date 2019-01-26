
extends Node

onready var root = get_tree().get_root()
onready var base_size = root.get_size()

var max_scale
var screen_scale

func _ready():
	# setup fullscreen preferences
	if not screen_scale:
		screen_scale = min(2, get_max_scale())
	update_resolution(min(screen_scale, get_max_scale()))

func _input(ev):
	if ev.is_action_pressed("META_TOGGLE_SCALE"):
		toggle_scale()

func set_scale(scale):
	screen_scale = max(1, scale)
	update_resolution(screen_scale)

func get_scale():
	return screen_scale

func toggle_scale():
	set_scale(int(screen_scale) % get_max_scale() + 1)

func update_resolution(scale):
	OS.window_resizable = true
	OS.request_attention()
	set_stretch_ratio(scale)
	OS.window_resizable = false

func set_stretch_ratio(scale):
	var screen_size = OS.get_screen_size()
	var target_size = base_size * scale
	var margin = ((screen_size - target_size) / 2).floor()
	OS.set_window_size(target_size)
	OS.set_window_position(margin)

func get_max_scale():
	if max_scale:
		return max_scale
	var screen_size = OS.get_screen_size()
	var ratio = (screen_size / base_size).floor()
	ratio.x = max(1, ratio.x)
	ratio.y = max(1, ratio.y)
	max_scale = int(min(ratio.x, ratio.y))
	return max_scale
