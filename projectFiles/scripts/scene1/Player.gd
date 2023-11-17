extends CharacterBody2D

var points = 0

@onready var anim = $AnimationPlayer
@onready var labelHUD = $"../Camera2D/HUD/PointsLabel"
@onready var fase_1 = $".."
@onready var labelFinal = $"../Camera2D/Final/PointsLabel"

func _ready():
	anim.play("player")

func _process(_delta):
	if !fase_1.pause:
		labelHUD.text = str(points)
	else:
		labelFinal.text = str(points)
	
func _input(event):
	if !fase_1.pause:
		trackPlayerPos(event)

func trackPlayerPos(event):
	if event is InputEventMouseMotion:
		if event.position.x < 0:
			position.x = -288
		elif event.position.x > 1150:
			position.x = 288
		else:
			position.x = remap(event.position.x, 0, 1150, -288, 288)
