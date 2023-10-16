extends CollisionShape2D

@onready var anim = $"../AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	anim.play("target")
	get_parent().position.y += 0.5

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		get_parent().queue_free()
		body.points += 1
		print(body.points)

