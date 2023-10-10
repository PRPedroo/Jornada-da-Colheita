extends CharacterBody2D

var points = 10
	
func _input(event):
	if event is InputEventMouseMotion:
		position.x = remap(event.position.x, 0, 1150, -288, 288)
