extends Area2D

@export var acceleration = 50 # How fast the player will accelerate (pixels/sec).

@export var drag_coefficient = 5 # the deceleration coefficient

@export var dampening = 0.9 # The ratio of speed remaining after colliding with a wall (inelasticity)

var screen_size # Size of the game window.

var velocity = Vector2.ZERO # The player's movement vector.

func _ready():
	screen_size = get_viewport_rect().size
	velocity.x = 300
	velocity.y = 500
	
func _process(delta):
	
	# rebound if hit top bottom or sides
	if position.x == screen_size.x || position.x == 0:
		velocity.x = velocity.x * -1 * dampening
	
	if position.y == screen_size.y || position.y == 0:
		velocity.y = velocity.y * -1 * dampening

	velocity.x += 0.5 * drag_coefficient / 100000 * velocity.x * abs(velocity.x) * -1 #creates wind resistance in opposite direction to motion 1/2*p*v^2*cd
	velocity.y += 0.5 * drag_coefficient / 100000 * velocity.y * abs(velocity.y) * -1 #creates wind resistance in opposite direction to motion
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
