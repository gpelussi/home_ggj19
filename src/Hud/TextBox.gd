extends NinePatchRect

onready var label = get_node("Label")
onready var timer = get_node("Timer")

signal dialogue_started
signal dialogue_finished
signal dialogue_advanced


func _ready():
	set_process_input(false)
	hide()

func run_dialogue(raw_script):
	emit_signal("dialogue_started")
	var box_texts = raw_script.split("\n\n")
	var idx = 0
	show()
	next_line(box_texts, 0)

func next_line(all_texts, idx):
	set_process_input(false)
	if idx >= all_texts.size():
		return stop_dialogue()
	var text = all_texts[idx]
	label.set_text(text)
	set_process_input(true)
	yield(self, "dialogue_advanced")
	next_line(all_texts, idx + 1)

func stop_dialogue():
	emit_signal("dialogue_finished")
	hide()

func _input(event):
	if event.is_action_pressed("ACTION_CONFIRM") or event.is_action_pressed("ACTION_JUMP"):
		emit_signal("dialogue_advanced")
