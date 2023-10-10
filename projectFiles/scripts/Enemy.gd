extends CharacterBody2D

var passo = 90
var moving = false
var vel = 60 # 50 ~ 70

var apple = preload("res://objects/apple.tscn")
var time = 0

var rng = RandomNumberGenerator.new()

@onready var target = $"../Target"
@onready var ai_controller = $AIController2D


func _process(delta):
	time += delta
	if time >= 10:
		ai_controller.reward -= 2
		randomizePosX()
		time = 0


func _ready():
	randomizePosX()

func _physics_process(delta):
	animeVerif2()
	playerStop()
	
	#Input.is_action_just_pressed("ui_left")
	
	if ai_controller.move < 0:
		moveL()
	elif ai_controller.move > 0:
		moveR()
	
	move_and_slide()

func moveR():
	if (position.x < target.position.x):
		ai_controller.reward += 1

	if (position.x < passo*2 and !moving):
		position.x += 2
		velocity.x = vel
		moving = true
	if position.x > (passo*2)-20:
		ai_controller.reward -= 2
func moveL():
	if (position.x > target.position.x):
		ai_controller.reward += 1

	if (position.x > -passo*2 and !moving):
		position.x -= 2
		velocity.x = -vel
		moving = true
	if position.x < (-passo*2)+20:
		ai_controller.reward -= 2

func _on_target_body_entered(body):
	instApple()
	target.randomizePosX()
	ai_controller.reward += 5
	time = 0
	
func randomizePosX():
	rng.randomize()
	position.x = rng.randi_range(-2, 2) * passo
	#ai_controller.reset()
	
func animeVerif():
	var yfac
	if velocity.x != 0:
		if int(position.x) % passo >= 0:
			yfac = (int(position.x) % passo/4)
		else:
			yfac = -(int(position.x) % passo/4)
		
		position.y = yfac * (yfac - (passo/4))
	
func animeVerif2():
	var yfac
	if velocity.x != 0:
		if int(position.x) % passo >= 0:
			yfac = (int(position.x) % passo/4)
		else:
			yfac = -(int(position.x) % passo/4)
		
		position.y = 8*sin(yfac/2) + 20
	
	
func playerStop():
	if int(position.x) % passo == 0 and moving == true:
		velocity = Vector2(0, 0)
		moving = false

func _on_target_body_exited(body):
	pass # Replace with function body.
	
func instApple():
	var instance = apple.instantiate()
	instance.position.x = target.position.x
	instance.position.y = target.position.y + 30
	get_parent().call_deferred("add_child", instance)
