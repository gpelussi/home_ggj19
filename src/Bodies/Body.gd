extends KinematicBody2D

const Physics = preload("Physics.gd")

signal landed_on_floor(position)

var velocity = Vector2()
var vertical_acceleration = 0

# OVERRIDE METHODS

func _ready():
	pass

func _physics_process(delta):
	move_and_slide(velocity, Physics.UP)
	accelerate_gravity()
	check_floor()
	deaccelerate()

# METHODS

func move_right():
	self.velocity += Physics.RIGHT * Physics.BASE_SPEED

func move_left():
	self.velocity += Physics.LEFT * Physics.BASE_SPEED

func jump():
	if is_on_floor():
		print("JUMPED")
		vertical_acceleration = 1
		self.velocity += Physics.UP * Physics.JUMP_STRENGTH * vertical_acceleration

func keep_jumping():
	if vertical_acceleration > 0 and not is_on_floor():
		vertical_acceleration = vertical_acceleration * Physics.DEACCELERATION
		self.velocity += Physics.UP * Physics.JUMP_STRENGTH * vertical_acceleration

func stop_jumping():
	vertical_acceleration = -1

func accelerate_gravity():
	if not is_on_floor():
		self.velocity += Physics.DOWN * Physics.GRAVITY

func check_floor():
	if vertical_acceleration != 0 and is_on_floor():
		velocity.y = 0
		vertical_acceleration = 0
		print("LANDED")
		emit_signal("landed_on_floor", self.position)

func deaccelerate():
	self.velocity *= Physics.DEACCELERATION
	if vertical_acceleration > Physics.EPSILON_SPEED:
		vertical_acceleration = 0
	if self.velocity.length_squared() <= Physics.EPSILON_SPEED:
		velocity.x = 0
		velocity.y = 0
