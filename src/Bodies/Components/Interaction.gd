extends Area2D

signal set_target
signal unset_target

var interaction_event
var targets = []

func _ready():
	if has_node("InteractionEvent"):
		interaction_event = get_node("InteractionEvent")
	connect("area_entered", self, "on_area_entered")
	connect("area_exited", self, "on_area_exited")

func on_area_entered(area):
	targets.append(area)
	for i in range(targets.size() - 1):
		targets[i].emit_signal("unset_target")
	get_target().emit_signal("set_target")

func on_area_exited(area):
	var idx = targets.find(area)
	if idx >= 0:
		targets[idx].emit_signal("unset_target")
		targets.remove(idx)

func get_target():
	return targets.back()

func interact():
	if interaction_event:
		interaction_event.try_to_trigger()
