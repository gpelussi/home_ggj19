extends CanvasLayer

signal faded_out
signal faded_in

const TRANSP = Color(1, 1, 1, 0)
const OPAQUE = Color(1, 1, 1, 1)

onready var overlay = get_node("Overlay")
onready var tween = get_node("Tween")

func _ready():
	overlay.set_modulate(TRANSP)

func fade_in(time):
	tween.interpolate_property(overlay, "modulate", OPAQUE, TRANSP, time,
			Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tween.start()
	yield(tween, "tween_completed")
	emit_signal("faded_in")
	
func fade_out(time):
	tween.interpolate_property(overlay, "modulate", TRANSP, OPAQUE, time,
			Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tween.start()
	yield(tween, "tween_completed")
	emit_signal("faded_out")
