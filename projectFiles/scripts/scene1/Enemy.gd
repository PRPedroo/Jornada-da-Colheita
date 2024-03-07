extends CharacterBody2D

var passo = 90
var moving = false
var BASEVEL = 50 # 50 ~ 65

var vel = 50

var apple = preload("res://objects/scene1/apple.tscn")
var time = 0

@onready var fase_1 = $".."

@onready var target = $"../Target"
@onready var anim = $AnimationPlayer

var neural_network = NeuralNetwork.new([2, 2], [2, 2], ["Linear", "Softmax"])
var np = NumpyHandmade.new()
var move
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
	neural_network.setWeightsBiases(1, [[-2.70293639897265, 0.08226924354481], [2.33982345258118, -0.73625284744846]], [0.0228172990154, 0.25131983175905])
	neural_network.setWeightsBiases(2, [[-2.60064180586105, 2.4219230160656], [0.29537280674141, -0.49685268994107]], [0.40718986278348, -0.29644009823899])
	randomizePosX()
	target.randomizePosX()
	move = neural_network.feedForward([[(position.x+0.001)/287.5, (target.position.x+0.001)/287.5]])

func _process(_delta):
	if !fase_1.pause:
		anim.play("enemy")
		
		#print([(position.x+0.001)/287.5, (target.position.x+0.001)/287.5])
		#print(move)
		
		vel = regulateVelocity()
		
		if np.argmax(move)[0] == 0:
			moveL()
		elif np.argmax(move)[0] == 1:
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
	move = neural_network.feedForward([[(position.x+0.001)/287.5, (target.position.x+0.001)/287.5]])
	print([position.x, target.position.x], "\n", move)
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
