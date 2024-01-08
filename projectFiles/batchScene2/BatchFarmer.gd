extends CharacterBody2D

@onready var fase_2 = $".."

const SPEED = 100
var timer = 60

var fruit = "apple"

var index = 0
var typeTarget = "nothing"
var positionTarget = Vector2(-184, 71)
@onready var ai_controller = $AIController2D
var compare = 0

var size = 0

var fruitsRemaining = 2

func _physics_process(delta):
	timer -= delta
	if timer < 0:
		ai_controller.reward -= 5.0
		position = Vector2(-154, 71)
		ai_controller.reset()
		timer = 60
	
	print("-----------------")
	print("é igual:", compare)
	print("fruta certa:", fruit)
	print("fruta olhando:", typeTarget)
	print("posição no vetor:", index, "/", size)
	print(fase_2.typeStack)
	print("-----------------")
	
	if position.x <= -17 and position.x >= -271 and position.y >= -76 and position.y <= 214:
		#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = Vector2(ai_controller.movex, ai_controller.movey).normalized() * SPEED
	else:
		velocity.x = 0
		velocity.y = 0
		ai_controller.reward -= 1.0
		position = Vector2(-154, 71)
		ai_controller.reset()
	
	size = fase_2.typeStack.size()-1
	typeTarget = fase_2.typeStack[index]
	positionTarget = fase_2.positionStack[index]
	
	if fruit == typeTarget:
		compare = 1
	else:
		compare = 0
	
	move_and_slide()

func gotRight():
	fruitsRemaining -= 1
	ai_controller.reward += 5.0
	timer = 60
	fase_2.numFruits -= 1
	if (fruitsRemaining == 0):
		fruit = "nothing"
	
func gotWrong():
	ai_controller.reward -= 5.0
	timer = 60
	# mostra um aviso de erro
	pass

func _on_original_pos_body_entered(body):
	if typeTarget == "nothing" and fruitsRemaining == 0:
		ai_controller.reward += 5.0
		timer = 60
		fruit = fase_2.changePackage()
		fruitsRemaining = fase_2.numFruits
