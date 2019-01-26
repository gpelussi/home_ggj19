extends KinematicBody2D

const Physics = preload("Physics.gd")

var velocity = Vector2()
var on_floor = true

# OVERRIDE METHODS

func _ready():
	pass

func _physics_process(delta):
	accelerate_gravity()
	move_and_slide(velocity, Physics.NORMAL)
	check_floor()
	deaccelerate()

# METHODS

func set_movement(movement):
	self.velocity += movement * Physics.BASE_SPEED

func accelerate_gravity():
	if not on_floor:
		self.velocity += Physics.GRAVITY

func check_floor():
	if is_on_floor() and not on_floor:
		on_floor = true
		velocity.y = 0
		emit_signal("landed_on_floor", self.position)

func deaccelerate():
	self.velocity *= Physics.DEACCELERATION
	if self.velocity.length_squared() <= Physics.EPSILON_SPEED:
		velocity *= 0
