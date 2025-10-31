extends CharacterBody2D

@export var drag_coefficient = 0.8 # deceleration 
@export var dampening = 0.9

var screen_size 
var click_time = 0 #saves duration of click for force calculations

var direction = Vector2.ZERO
var speed = Vector2.ZERO

var mouse_pressed = false #variable for detecting mouse press used by aim pointer child node

var world_size = Vector2(3600, 2000) #variable for world (larger than player camera)

func _ready():
	screen_size = get_viewport_rect().size
	velocity = Vector2.ZERO  #velocity is built into characterbody2d

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		click_time = Time.get_ticks_msec()
		mouse_pressed = true	
	
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT: #button is released
		mouse_pressed = false	
		click_time = Time.get_ticks_msec() - click_time
		speed = click_time * 2
		if speed > 1000: speed = 1000
		var mouse_pos = get_global_mouse_position()
		direction = (mouse_pos - position).normalized()
		
		## Reset velocity 
		#velocity = Vector2.ZERO
		# opposite click thingy bro idk it works
		velocity -= direction * speed
		
func _physics_process(delta): #new function for handling collisions
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal()) * dampening

#func _process(delta):
	#if position.x >= world_size.x or position.x <= 0:
		#velocity.x = -velocity.x * dampening
	#if position.y >= world_size.y or position.y <= 0:
		#velocity.y = -velocity.y * dampening
#
	# drag dubse
	velocity.x += 0.5 * drag_coefficient / 100000 * velocity.x * abs(velocity.x) * -1 - velocity.x * 0.0022
	velocity.y += 0.5 * drag_coefficient / 100000 * velocity.y * abs(velocity.y) * -1 - velocity.y * 0.0022
	#
	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO, world_size)
