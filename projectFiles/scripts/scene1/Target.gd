extends Area2D

@onready var enemy = $"../Enemy"
@onready var anim = $AnimationPlayer

var rng = RandomNumberGenerator.new()

var lastPos

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("target")
	randomizePosX()

func randomizePosX():
	get_node("Sprite2D").texture = load(get_node("../Apples").vecSprites[get_node("../Apples").contTarget])
	lastPos = position
	while (lastPos == position):	
		rng.randomize()
		@warning_ignore("narrowing_conversion")
		position.x = float(rng.randi_range(-2.0, 2.0) * enemy.passo)
	get_node("../Apples").nextSprite()
