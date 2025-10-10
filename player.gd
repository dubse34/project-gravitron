extends Area2D

@export var thrust_force = 300.0 #  strength of click
@export var drag_coefficient = 5.0 # deceleration 
@export var dampening = 0.9 

var screen_size 
var velocity = Vector2.ZERO 

func _ready():
	screen_size = get_viewport_rect().size

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_global_mouse_position()
		var direction = (mouse_pos - position).normalized()
		
		# Reset velocity 
		velocity = Vector2.ZERO
		# opposite click thingy bro idk it works
		velocity -= direction * thrust_force

func _process(delta):
	
	if position.x >= screen_size.x or position.x <= 0:
		velocity.x = -velocity.x * dampening
	if position.y >= screen_size.y or position.y <= 0:
		velocity.y = -velocity.y * dampening

	# drag dubse
	velocity.x += 0.5 * drag_coefficient / 100000 * velocity.x * abs(velocity.x) * -1
	velocity.y += 0.5 * drag_coefficient / 100000 * velocity.y * abs(velocity.y) * -1

	if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
