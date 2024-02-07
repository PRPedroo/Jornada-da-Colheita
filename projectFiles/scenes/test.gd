extends CharacterBody2D

var SPEED = 10
@export_range(0, 1, 0.1) var backForce:float = 0.5
var maxDegrees = 20
var dir

var dense1
var dense2
var activation1
var activation2

# Called when the node enters the scene tree for the first time.
func _ready():
	dense1 = Layer_Dense.new()
	dense1.initialize([[-8.953169308995498898e-01, 3.068421357380452186e+00], [-2.740990893498600922e+00, -5.064557105555514971e-01]],
	[2.190949460736625110e+00, -1.559169505695218449e-01])
	
	dense2 = Layer_Dense.new()
	dense2.initialize([[-1.682435397909829211e+00, 2.754165550493389514e+00, -1.391125643397175260e+00],
	[-2.699270200510405227e-01, -9.641011783391013612e-01, 3.298179732881735937e+00]], [2.318335155313265616e+00, -4.203238170725078215e-01, -8.770413005531592088e-01])
	
	activation1 = Activation_ReLU.new()
	activation2 = Activation_Softmax.new()

func _process(delta):
	if rotation_degrees <= maxDegrees and rotation_degrees >= -maxDegrees:
		#if Input.is_key_pressed(KEY_RIGHT):
		if dir == 2:
			rotation_degrees += 0.5
		#if Input.is_key_pressed(KEY_LEFT):
		if dir == 0:
			rotation_degrees -= 0.5
	else:
		rotation_degrees = (rotation_degrees/(maxDegrees+1)) * maxDegrees
	
	#if !Input.is_key_pressed(KEY_LEFT) and !Input.is_key_pressed(KEY_RIGHT):
	if dir == 1:
		if floor(rotation_degrees) != 0:
			rotation_degrees -= rotation_degrees*backForce
		else:
			rotation_degrees = 0
	
	velocity.x = rotation_degrees * SPEED
	move_and_slide()

func run_neural_network():
	dense1.forward([[get_node("LeftSensor").left, get_node("RightSensor").right]])
	activation1.forward(dense1.output)
	dense2.forward(activation1.output)
	activation2.forward(dense2.output)
	
	var max_value = activation2.output[0][0]  # Inicializa o valor máximo com o primeiro elemento
	var max_index = 0  # Inicializa o índice do valor máximo
	
	# Percorre o vetor para encontrar o maior valor e sua posição
	for i in range(len(activation2.output[0])):
		if activation2.output[0][i] > max_value:
			max_value = activation2.output[0][i]
			max_index = i
	var vec = ["esquerda", "reto", "direita"]
	dir = max_index
	print(activation2.output)
	print(vec[max_index])
	
