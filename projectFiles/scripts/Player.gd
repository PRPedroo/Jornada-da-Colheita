extends CharacterBody2D

var points = 0
@onready var anim = $AnimationPlayer

func _process(delta):
	anim.play("player")
	
func _input(event):
	if event is InputEventMouseMotion:
		position.x = remap(event.position.x, 0, 1150, -288, 288)
