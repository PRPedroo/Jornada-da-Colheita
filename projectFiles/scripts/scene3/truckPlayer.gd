extends CharacterBody2D

var SPEED = 10
@export_range(0, 1, 0.1) var backForce:float = 0.5
var maxDegrees = 20
var dir

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rotation_degrees <= maxDegrees and rotation_degrees >= -maxDegrees:
		#if Input.is_key_pressed(KEY_RIGHT):
		if dir == 2:
			rotation_degrees += 0.5
		#if Input.is_key_pressed(KEY_LEFT):
		if dir == 0:
			rotation_degrees -= 0.5
	else:
		rotation_degrees = (rotation_degrees/(maxDegrees+1)) * maxDegrees
	
	#if !Input.is_key_pressed(KEY_LEFT) and !Input.is_key_pressed(KEY_RIGHT):
	if dir == 1:
		if floor(rotation_degrees) != 0:
			rotation_degrees -= rotation_degrees*backForce
		else:
			rotation_degrees = 0
	
	velocity.x = rotation_degrees * SPEED
	move_and_slide()
