extends Area2D

@onready var character = $"../Enemy"

var rng = RandomNumberGenerator.new()

var lastPos

# Called when the node enters the scene tree for the first time.
func _ready():
	lastPos = position
	randomizePosX()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func randomizePosX():
	lastPos = position
	while (lastPos == position):	
		rng.randomize()
		position.x = rng.randi_range(-2.0, 2.0) * character.passo
