extends CharacterBody2D

var points = 0
@onready var anim = $AnimationPlayer
@onready var fase_1 = $".."

func _ready():
	anim.play("player")

func _input(event):
	if !fase_1.pause:
		if event is InputEventMouseMotion:
			if event.position.x < 0:
				position.x = -288
			elif event.position.x > 1150:
				position.x = 288
			else:
				position.x = remap(event.position.x, 0, 1150, -288, 288)
