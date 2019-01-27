extends KinematicBody2D

const Physics = preload("Physics.gd")

signal landed
signal jumped
signal moved
signal stopped
signal directed
signal fanfare
signal talked

var velocity = Vector2()
var is_jumping = true
var is_moving = false

# OVERRIDE METHODS

func _ready():
	pass

func _enter_tree():
	add_to_group("Bodies")

func _exit_tree():
	remove_from_group("Bodies")

func _physics_process(delta):
	move_and_slide(velocity, Physics.UP)
	accelerate_gravity()
	check_floor()
	deaccelerate()

# METHODS

func move_right():
	self.velocity += Physics.RIGHT * Physics.BASE_SPEED
	emit_signal("directed", "right")
	if not self.is_moving:
		self.is_moving = true
		emit_signal("moved")

func move_left():
	self.velocity += Physics.LEFT * Physics.BASE_SPEED
	emit_signal("directed", "left")
	if not self.is_moving:
		self.is_moving = true
		emit_signal("moved")

func jump():
	if is_on_floor():
		self.velocity += Physics.UP * Physics.JUMP_STRENGTH
		self.is_jumping = true
		emit_signal("jumped")

func stop():
	self.velocity.x = 0
	self.is_moving = false
	emit_signal("stopped")

func talk():
	emit_signal("talked")

func fanfare():
	emit_signal("fanfare")

func accelerate_gravity():
	if not is_on_floor():
		self.velocity += Physics.DOWN * Physics.GRAVITY

func check_floor():
	if self.is_jumping and is_on_floor():
		self.velocity.y = 0
		self.is_jumping = false
		emit_signal("landed")

func deaccelerate():
	self.velocity.x *= Physics.DEACCELERATION
	if abs(self.velocity.x) < Physics.EPSILON_SPEED:
		if is_moving and is_on_floor():
			stop()
