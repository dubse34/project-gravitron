extends Area2D

var charge_value = 0

var pointer_direction = Vector2.ZERO

func _process(delta):
	if get_parent().mouse_pressed: #when mouse is pressed use duration of press to set distance of indicator from player
		charge_value = (Time.get_ticks_msec() - get_parent().click_time)
		
		if charge_value > 500: charge_value = 500
		
		pointer_direction = (get_global_mouse_position() - get_parent().position).normalized()
		
		position = pointer_direction * charge_value * -1 #set indicator position in opposite direction to mouse
	
	else:
		position = Vector2.ZERO #set position to zero when mouse isnt pressed
