extends CharacterBody2D

@onready var fase_2 = $".."
@onready var animation = $AnimationPlayer

const SPEED = 100

var fruit = "apple"

var typeTarget = "nothing"
var positionTarget = Vector2(-118, 162)

var objective = false

@onready var ai_controller = $AIController2D

func _ready():
	animation.play("farmer")
	refreshFruit()

func _physics_process(_delta):
	if !fase_2.pause:
		if typeTarget != "nothing":
			objective = true
		
		if objective:
			#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			velocity.x = ai_controller.movex * SPEED
			velocity.y = ai_controller.movey * SPEED
		else:
			velocity.x = 0
			velocity.y = 0
		
		move_and_slide()

func verifyPos():
	if position.x > -17:
		position.x = -17
	elif position.x < -271:
		position.x = -271 
	elif position.y < -76:
		position.y = -76
	elif position.y > 214:
		position.y = 214
		
func gotRight():
	fase_2.numFruits -= 1
	
func gotWrong():
	# mostra um aviso de erro
	fase_2.get_parent().addMistakes()
	
func refreshFruit():
	typeTarget = fase_2.typeStack[fase_2.typeStack.size()-1]
	positionTarget = fase_2.positionStack[fase_2.positionStack.size()-1]
	print(typeTarget)
	print(positionTarget)

func _on_original_pos_body_entered(body):
	if typeTarget == "nothing":
		if fase_2.numFruits == 0:
			fruit = fase_2.changePackage()
		objective = false
