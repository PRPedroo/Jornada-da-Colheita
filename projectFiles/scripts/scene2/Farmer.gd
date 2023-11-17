extends CharacterBody2D

@onready var fase_2 = $".."

const SPEED = 100

var fruit = "apple"

func _physics_process(_delta):
	if !fase_2.pause:
		if position.x <= -17 and position.x >= -271 and position.y >= -76 and position.y <= 214:
			var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			velocity = direction * SPEED
		else:
			velocity.x = 0
			velocity.y = 0
			verifyPos()
		
		move_and_slide()
	
func _process(_delta):
	if (fase_2.numFruits == 0):
		fruit = fase_2.changePackage()

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
