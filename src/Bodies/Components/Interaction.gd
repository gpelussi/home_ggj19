extends Area2D

var interaction_event
var targets = []

func _ready():
	if has_node("InteractionEvent"):
		interaction_event = get_node("InteractionEvent")
	connect("area_entered", get_parent(), "on_area_entered")
	connect("area_exited", get_parent(), "on_area_exited")

func on_area_entered(area):
	targets.append(area)

func on_area_exited(area):
	var idx = targets.find(area)
	if idx >= 0:
		targets.remove(idx)

func get_target():
	return targets.back()

func interact():
	if interaction_event:
		interaction_event.try_to_trigger()
