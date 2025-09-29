extends Area2D

@export var acceleration = 50 # How fast the player will accelerate (pixels/sec).

@export var drag_coefficient = 5 # the deceleration coefficient

var screen_size # Size of the game window.

var velocity = Vector2.ZERO # The player's movement vector.

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	if Input.is_action_pressed("move_right"):
		velocity.x += acceleration
	if Input.is_action_pressed("move_left"):
		velocity.x -= acceleration
	if Input.is_action_pressed("move_down"):
		velocity.y += acceleration
	if Input.is_action_pressed("move_up"):
		velocity.y -= acceleration

	velocity.x += 0.5 * drag_coefficient / 100000 * velocity.x * abs(velocity.x) * -1 #creates wind resistance in opposite direction to motion 1/2*p*v^2*cd
	velocity.y += 0.5 * drag_coefficient / 100000 * velocity.y * abs(velocity.y) * -1 #creates wind resistance in opposite direction to motion

	if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
