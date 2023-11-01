extends CollisionShape2D

@onready var anim = $"../AnimationPlayer"
var vel = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	vel = vel + (0.2 * get_parent().get_parent().get_parent().get_parent().dificulty)
	anim.play("target")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !get_parent().get_parent().get_parent().pause:
		get_parent().position.y += vel # 0.5 ~ 1.5
		if get_parent().position.y >= 230:
			get_parent().get_parent().get_parent().get_parent().mistakes += 1
			get_parent().queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		get_parent().queue_free()
		body.points += 1
		#print(body.points)

