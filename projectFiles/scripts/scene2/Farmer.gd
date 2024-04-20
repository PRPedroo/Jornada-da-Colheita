extends CharacterBody2D

@onready var fase_2 = $".."
@onready var animation = $AnimationPlayer

const SPEED = 100

var fruit = "apple"

var typeTarget = "nothing"
var positionTarget = Vector2(-118, 162)

var objective = false

var movex = 0
var movey = 0

var w1 = 0.5
var w2 = 0.5
var b = 0.5

#var vect = Vector2(positionTarget.x - position.x, positionTarget.y - position.y)
var X = []
var y = []

var neural_network = NeuralNetwork.new([4, 2], ["Linear", "Linear"])

func _ready():
	animation.play("farmer")
	refreshFruit()

func _physics_process(delta):
	if !fase_2.pause:
		if typeTarget != "nothing":
			objective = true
		
		verifyPos()
		
		if objective:
			#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			if len(y) > 50:
				y.clear()
				X.clear()
			y.append([positionTarget.x/1150 - position.x/1150, positionTarget.y/650 - position.y/650])
			X.append([position.x/1150, position.y/650, positionTarget.x/1150, positionTarget.y/650])
			neural_network.train(X, y, 1, 0.02)
			var move = neural_network.feedForward([[position.x/1150, position.y/650, positionTarget.x/1150, positionTarget.y/650]])
			velocity = Vector2(move[0][0], move[0][1]).normalized() * SPEED
		else:
			velocity.x = 0
			velocity.y = 0
		
		move_and_slide()

func verifyPos():
	if position.x > -17 or position.x < -271 or position.y < -76 or position.y > 214:
		position = Vector2(-150, 70)
		
func gotRight():
	fase_2.numFruits -= 1
	print("Pegou a fruta certa!")

func gotWrong():
	# mostra um aviso de erro
	fase_2.get_parent().addMistakes()
	print("Pegou a fruta errada!")

func refreshFruit():
	typeTarget = fase_2.typeStack[fase_2.typeStack.size()-1]
	positionTarget = fase_2.positionStack[fase_2.positionStack.size()-1]
	print("---------")
	print(typeTarget)
	print(positionTarget)
	if typeTarget != fruit and typeTarget != "nothing":
		fase_2.removeFruitStack()
		gotWrong()

func _on_original_pos_body_entered(body):
	if typeTarget == "nothing":
		if fase_2.numFruits == 0:
			fruit = fase_2.changePackage()
		objective = false
