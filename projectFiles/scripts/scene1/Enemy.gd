extends CharacterBody2D

var passo = 90
var moving = false
var BASEVEL = 50 # 50 ~ 65

var vel = 50

var apple = preload("res://objects/scene1/apple.tscn")
var time = 0

@onready var fase_1 = $".."

@onready var target = $"../Target"
@onready var ai_controller = $AIController2D
@onready var anim = $AnimationPlayer

'''
isso foi utilizado para treinar o agente
var time = 0
func _process(delta):
	if !fase_1.pause:
		time += delta
		if time >= 10:
			ai_controller.reward -= 2
			randomizePosX()
			time = 0
'''

func _ready():
	randomizePosX()

func _process(_delta):
	if !fase_1.pause:
		anim.play("enemy")
		
		vel = regulateVelocity()
		
		if ai_controller.move < 0:
			moveL()
		elif ai_controller.move > 0:
			moveR()
		
		move_and_slide()
	else:
		anim.play("enemy_idle")

func moveR():
	'''
	if (position.x < target.position.x):
		ai_controller.reward += 1
	if position.x > (passo*2)-20:
		ai_controller.reward -= 2
	'''
	if (position.x < passo*2):
		velocity.x = vel

func moveL():
	'''
	if (position.x > target.position.x):
		ai_controller.reward += 1
	if position.x < (-passo*2)+20:
		ai_controller.reward -= 2
	'''
	if (position.x > -passo*2):
		velocity.x = -vel

func _on_target_body_entered(_body):
	instantiateApple()
	target.randomizePosX()
	#ai_controller.reward += 5
	#time = 0

func randomizePosX():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	position.x = rng.randi_range(-2, 2) * passo
	#ai_controller.reset()

func instantiateApple():
	var instance = apple.instantiate()
	instance.position.x = target.position.x
	instance.position.y = target.position.y + 30
	get_node("../Apples").call_deferred("add_child", instance)

func regulateVelocity() -> int:
	return BASEVEL + fase_1.get_parent().difficultyFase1 * 3
