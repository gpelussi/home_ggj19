extends NinePatchRect

onready var label = get_node("Label")
onready var timer = get_node("Timer")
onready var player_input = get_node("/root/PlayerInput")

signal dialogue_started
signal dialogue_finished
signal dialogue_advanced

func _ready():
	set_process_input(false)
	hide()

func run_dialogue(text):
	emit_signal("dialogue_started")
	player_input.lock_input()
	print(text)
	var box_texts = text.split("\n\n")
	show()
	for box_text in box_texts:
		label.set_text(box_text)
		timer.start()
		yield(timer, "timeout")
		set_process_input(true)
		yield(self, "dialogue_advanced")
		set_process_input(false)
	hide()
	player_input.unlock_input()
	emit_signal("dialogue_finished")

func _input(event):
	if event.is_action_pressed("ACTION_CONFIRM") or event.is_action_pressed("ACTION_JUMP"):
		emit_signal("dialogue_advanced")
