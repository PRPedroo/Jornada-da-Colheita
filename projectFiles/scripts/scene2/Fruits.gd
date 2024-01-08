extends CollisionShape2D

@onready var anim = $"../AnimationPlayer"
var fruit
var vecFruits
var fase2

var isIn = true
var isDrag = false

var added = false

func _ready():
	fruit = get_parent()
	vecFruits = get_parent().get_parent()
	fase2 = get_parent().get_parent().get_parent()
	
	anim.play("target")
	
	randomizePos()

func _process(_delta):
	if !get_parent().get_parent().get_parent().pause:
		if isIn:
			if Input.is_action_just_pressed("click") and !fase2.grabbed and !added:
				get_parent().get_parent().move_child(get_parent(), vecFruits.get_child_count()-1)
				fase2.grabbed = true
				isDrag = true
		if dropAround() == true or Input.is_action_just_released("click"):
				if get_parent().position.x < 0 and !added:
					while checkOut() == true:
						pass
					fase2.addFruitStack(str(get_parent().get_groups()[0]), Vector2(get_parent().position))
					added = true
				fase2.grabbed = false
				isDrag = false
		checkOut() ## APRESENTA UM ERRO AO TENTAR COLOCAR A MAÇÃ FORA DO MAPA
	
func _input(event):
	if !get_parent().get_parent().get_parent().pause: #problema pra batch
		if event is InputEventMouse:
			if remap(event.position.x, 0, 1150, -288, 288) > get_parent().position.x - 25 and remap(event.position.x, 0, 1150, -288, 288) < get_parent().position.x + 25 and remap(event.position.y, 0, 650, -93, 233) > get_parent().position.y - 25 and remap(event.position.y, 0, 650, -93, 233) < get_parent().position.y + 25:
				isIn = true
			else:
				isIn = false

			if isDrag:
				get_parent().position.x = remap(event.position.x, 0, 1150, -288, 288)
				get_parent().position.y = remap(event.position.y, 0, 650, -93, 233)

func _on_area_2d_body_entered(body):
	if body.is_in_group("farmer"):
		if get_parent().position == body.positionTarget:
			if get_parent().get_groups()[0] == body.fruit:
				body.gotRight()
				fruit.queue_free()
				fase2.grabbed = false
			else:
				body.gotWrong()
				fruit.queue_free()
				fase2.grabbed = false
			fase2.removeFruitStack()

func dropAround():
	var radius = 60
	if fase2.get_node("Farmer").position.x + radius > get_parent().position.x and fase2.get_node("Farmer").position.x - radius < get_parent().position.x and fase2.get_node("Farmer").position.y - radius < get_parent().position.y and fase2.get_node("Farmer").position.y + radius > get_parent().position.y:
		return true

func randomizePos():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	fruit.position.x = rng.randf_range(40.0, 230.0)
	fruit.position.y = rng.randf_range(-10.0, 180.0)
	
func checkOut():
	if get_parent().position.x < -265:
		get_parent().position.x = get_parent().position.x + 20
		isIn = false
		isDrag = false
		return true
	if get_parent().position.x > 255:
		get_parent().position.x = get_parent().position.x - 20
		isIn = false
		isDrag = false
		return true
	if get_parent().position.y < -50:
		get_parent().position.y = get_parent().position.y + 20
		isIn = false
		isDrag = false
		return true
	if get_parent().position.y > 200:
		get_parent().position.y = get_parent().position.y -20
		isIn = false
		isDrag = false
		return true
	return false
