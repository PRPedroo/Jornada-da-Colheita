extends CharacterBody2D

var points = 0
@onready var anim = $AnimationPlayer
@onready var labelHUD = $"../Camera2D/HUD/PointsLabel"
@onready var fase_1 = $".."
@onready var labelFinal = $"../Camera2D/Final/PointsLabel"

func _ready():
	anim.play("player")

func _process(delta):
	if !fase_1.end:
		labelHUD.text = str(points)
	else:
		calcPoints()
	
func _input(event):
	if !fase_1.end:
		if event is InputEventMouseMotion:
			if event.position.x < 0:
				position.x = -288
			elif event.position.x > 1150:
				position.x = 288
			else:
				position.x = remap(event.position.x, 0, 1150, -288, 288)

func calcPoints():
	labelFinal.text = str(points)
