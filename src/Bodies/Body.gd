extends KinematicBody2D

const Physics = preload("Physics.gd")

signal landed_on_floor(position)

var velocity = Vector2()
var jump_phase = -1

# OVERRIDE METHODS

func _ready():
	pass

func _physics_process(delta):
	move_and_slide(velocity, Physics.UP)
	accelerate_gravity()
	check_floor()
	deaccelerate()

# METHODS

func set_movement(movement):
	self.velocity += movement * Physics.BASE_SPEED

func jump():
	if jump_phase >= 0:
		if jump_phase == 0:
			jump_phase = Physics.JUMP
		self.velocity += Physics.UP * jump_phase
		jump_phase *= 0.9
		if jump_phase <= Physics.EPSILON_SPEED:
			jump_phase = -1

func accelerate_gravity():
	if not is_on_floor():
		self.velocity += Physics.DOWN * Physics.GRAVITY

func check_floor():
	if jump_phase != 0 and is_on_floor():
		print("landed!")
		jump_phase = 0
		velocity.y = 0
		emit_signal("landed_on_floor", self.position)

func deaccelerate():
	self.velocity *= Physics.DEACCELERATION
	if self.velocity.length_squared() <= Physics.EPSILON_SPEED:
		velocity *= 0
