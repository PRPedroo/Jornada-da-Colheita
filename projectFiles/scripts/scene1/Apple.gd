extends CollisionShape2D

@onready var anim = $"../AnimationPlayer"

var vel = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("../Sprite2D").texture = load(get_parent().get_parent().vecSprites[get_parent().get_parent().contFruit])
	vel = vel + (0.2 * get_parent().get_parent().get_parent().get_parent().difficultyFase1)
	anim.play("target")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !get_parent().get_parent().get_parent().pause:
		get_parent().position.y += vel # 0.5 ~ 1.5
		if get_parent().position.y >= 230:
			get_parent().get_parent().get_parent().get_parent().addMistakes()
			get_parent().queue_free()
