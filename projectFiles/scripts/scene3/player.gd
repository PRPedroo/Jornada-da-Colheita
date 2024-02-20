extends CharacterBody2D

var turning_speed = 10
var speed = 90
@export_range(0, 1, 0.1) var backForce:float = 0.5
var maxDegrees = 20
var stunned = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if(!get_parent().pause):
		if(!stunned):
			if speed > 50:
				speed -= 0.2
		else:
			if speed < 150:
				speed += 0.8
		
		if rotation_degrees <= maxDegrees and rotation_degrees >= -maxDegrees:
			if Input.is_key_pressed(KEY_RIGHT):
				rotation_degrees += 0.5
			if Input.is_key_pressed(KEY_LEFT):
				rotation_degrees -= 0.5
		else:
			rotation_degrees = (rotation_degrees/(maxDegrees+1)) * maxDegrees
		
		if !Input.is_key_pressed(KEY_LEFT) and !Input.is_key_pressed(KEY_RIGHT):
			if floor(rotation_degrees) != 0:
				rotation_degrees -= rotation_degrees*backForce
			else:
				rotation_degrees = 0
		
		position.y = speed
		velocity.x = rotation_degrees * turning_speed
		move_and_slide()

func knockback(force):
	position.y += force


func _on_area_2d_area_entered(area):
	if area.get_parent().get_groups()[0] == "road":
		knockback(10)
		stunned = true


func _on_area_2d_area_exited(area):
	if area.get_parent().get_groups()[0] == "road":
		stunned = false
