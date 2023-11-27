extends CollisionShape2D

@onready var anim = $"../AnimationPlayer"
var fruit
var vecFruits
var fase2

func _ready():
	fruit = get_parent()
	vecFruits = get_parent().get_parent()
	fase2 = get_parent().get_parent().get_parent()
	
	anim.play("target")
	
	randomizePos()

func _on_area_2d_body_entered(body):
	if body.is_in_group("farmer"):
		if get_parent().position == body.positionTarget:
			if get_parent().get_groups()[0] == body.fruit:
				body.gotRight()
				fruit.queue_free()
			else:
				body.gotWrong()
				fruit.queue_free()
			fase2.removeFruitStack()

func randomizePos():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	fruit.position.x = rng.randf_range(40.0, 230.0)
	fruit.position.y = rng.randf_range(-10.0, 180.0)
