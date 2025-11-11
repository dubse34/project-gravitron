extends CharacterBody2D

var pos:Vector2
var dir:Vector2
var speed:int

func _ready():
	global_position=pos

func _physics_process(delta):
	velocity=speed*dir
	move_and_slide()
