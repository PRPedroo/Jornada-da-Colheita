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

func _ready():
	runNN()
	animation.play("farmer")
	refreshFruit()

func _physics_process(_delta):
	if !fase_2.pause:
		if typeTarget != "nothing":
			objective = true
		
		verifyPos()
		
		if objective:
			#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			velocity = Vector2(movex, movey).normalized() * SPEED
			'''
			velocity.x = ai_controller.movex * SPEED
			velocity.y = ai_controller.movey * SPEED
			'''
		else:
			velocity.x = 0
			velocity.y = 0
		
		move_and_slide()

func verifyPos():
	if position.x > -17 or position.x < -271 or position.y < -76 or position.y > 214:
		position = Vector2(-150, 70)
		runNN()
		
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
	else:
		runNN()

func _on_original_pos_body_entered(body):
	if typeTarget == "nothing":
		if fase_2.numFruits == 0:
			fruit = fase_2.changePackage()
		objective = false

func NN(imput1, imput2, weight1, weight2, bias):
	var z1 = imput1 * weight1 + bias
	var z2 = imput2 * weight2 + bias
	return [sigmoid(z1), sigmoid(z2)]

func sigmoid(x):
	return 1/(1 + pow(2.718282, (-x)))

func cost(b):
	var vect = Vector2(positionTarget.x - position.x, positionTarget.y - position.y)
	#vect = vect.normalized()
	return [(b[0] - vect.x) * 2 * 2, (b[1] - vect.y) * 2 * 2]

func slope(b):
	var vect = Vector2(positionTarget.x - position.x, positionTarget.y - position.y)
	#vect = vect.normalized()
	return [2*(b[0] - vect.x), 2*(b[1] - vect.y)]

func runNN():
	w1 = RandomNumberGenerator.new().randf_range(0, 1)
	w2 = RandomNumberGenerator.new().randf_range(0, 1)
	b = RandomNumberGenerator.new().randf_range(0, 1)
	var res = NN(0.5, 0.5, w1, w2, b)
	
	for i in range(10):
		res[0] = res[0] - (0.1 * slope(res)[0])
		res[1] = res[1] - (0.1 * slope(res)[1])
		movex = res[0]
		movey = res[1]
