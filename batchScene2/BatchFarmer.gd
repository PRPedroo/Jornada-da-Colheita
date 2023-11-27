extends CharacterBody2D

@onready var fase_2 = $".."

const SPEED = 100
var timer = 60

var fruit = "apple"

var typeTarget = "nothing"
var positionTarget = Vector2(-184, 71)
@onready var ai_controller = $AIController2D

func _ready():
	refreshFruit()

func _physics_process(delta):
	timer -= delta
	if timer < 0:
		ai_controller.reward -= 5.0
		position = Vector2(-154, 71)
		ai_controller.reset()
		timer = 60
	if position.x <= -17 and position.x >= -271 and position.y >= -76 and position.y <= 214:
		#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity.x = ai_controller.movex * SPEED
		velocity.y = ai_controller.movey * SPEED
	else:
		velocity.x = 0
		velocity.y = 0
		ai_controller.reward -= 1.0
		position = Vector2(-154, 71)
		ai_controller.reset()
		
	move_and_slide()

func gotRight():
	ai_controller.reward += 5.0
	timer = 60
	fase_2.numFruits -= 1
	
func gotWrong():
	ai_controller.reward += 5.0
	timer = 60
	# mostra um aviso de erro
	pass
	
func refreshFruit():
	typeTarget = fase_2.typeStack[fase_2.typeStack.size()-1]
	positionTarget = fase_2.positionStack[fase_2.positionStack.size()-1]

func _on_original_pos_body_entered(body):
	if typeTarget == "nothing":
		ai_controller.reward += 5.0
		timer = 60
		fruit = fase_2.changePackage()
