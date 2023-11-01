extends CharacterBody2D

var passo = 90
var moving = false
var BASEVEL = 50 # 50 ~ 65

var vel = 50

var apple = preload("res://objects/scene1/apple.tscn")
var time = 0

var rng = RandomNumberGenerator.new()

@onready var fase_1 = $".."

@onready var target = $"../Target"
@onready var ai_controller = $AIController2D
@onready var anim = $AnimationPlayer


func _process(delta):
	if !fase_1.pause:
		time += delta
		if time >= 10:
			ai_controller.reward -= 2
			randomizePosX()
			time = 0


func _ready():
	print("cm")
	randomizePosX()
	anim.play("enemy")

func _physics_process(delta):
	if !fase_1.pause:
		vel = BASEVEL + fase_1.get_parent().dificulty * 3
		animeVerif()
		playerStop()
		
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
		
		position.y = 8*sin(yfac/2)
	
	
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
	get_node("../Apples").call_deferred("add_child", instance)
