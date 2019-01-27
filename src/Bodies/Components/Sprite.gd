extends Node2D

onready var animation_player = get_node("AnimationPlayer")

func _ready():
	var body = get_parent()
	body.connect("stopped", self, "set_idle")
	body.connect("landed", self, "set_land")
	body.connect("jumped", self, "set_jump")
	body.connect("moved", self, "set_walk")
	body.connect("talked", self, "set_talk")
	body.connect("directed", self, "set_direction")
	body.connect("fanfare", self, "set_fanfare")

func set_idle():
	animation_player.play("Idle")

func set_walk():
	animation_player.play("Walk")

func set_talk():
	animation_player.play("Talk")

func set_fanfare():
	animation_player.play("Fanfare")

func set_jump():
	animation_player.play("Jump")

func set_land():
	animation_player.play("Land")
	yield(animation_player, "animation_finished")
	if get_parent().is_moving:
		animation_player.play("Walk")
	else:
		animation_player.play("Idle")

func set_direction(direction):
	if direction == "right":
		self.scale.x = -1
	elif direction == "left":
		self.scale.x = 1
