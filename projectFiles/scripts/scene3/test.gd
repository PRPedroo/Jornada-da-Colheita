extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

var SPEED = 5
var backForce:float = 0.1
var maxDegrees = 20 *2
var dir

var neural_network = NeuralNetwork.new([2, 3], [2, 3], ["ReLU", "Softmax"])

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("idle")
	neural_network.setWeightsBiases(1, [[-8.953169308995498898e-01, 3.068421357380452186e+00], [-2.740990893498600922e+00, -5.064557105555514971e-01]], [2.190949460736625110e+00, -1.559169505695218449e-01])
	neural_network.setWeightsBiases(2, [[-1.682435397909829211e+00, 2.754165550493389514e+00, -1.391125643397175260e+00], [-2.699270200510405227e-01, -9.641011783391013612e-01, 3.298179732881735937e+00]], [2.318335155313265616e+00, -4.203238170725078215e-01, -8.770413005531592088e-01])

func _process(delta):
	if !get_parent().pause and !get_parent().end:
		if rotation_degrees <= maxDegrees and rotation_degrees >= -maxDegrees:
			#if Input.is_key_pressed(KEY_RIGHT):
			if dir == 2:
				rotation_degrees += 0.5 *2
			#if Input.is_key_pressed(KEY_LEFT):
			if dir == 0:
				rotation_degrees -= 0.5 *2
		else:
			rotation_degrees = (rotation_degrees/(maxDegrees+1)) * maxDegrees
		
		#if !Input.is_key_pressed(KEY_LEFT) and !Input.is_key_pressed(KEY_RIGHT):
		if dir == 1:
			if floor(rotation_degrees) != 0:
				rotation_degrees -= rotation_degrees*backForce
			else:
				rotation_degrees = 0
		
		velocity.x = rotation_degrees/2 * SPEED
		move_and_slide()
	
	elif get_parent().end and !get_parent().pause:
		if position.y <= 185:
			position.y += 2 * ((186-position.y)/186)
		else:
			position.y = 185
		move_and_slide()

func decide():
	var x = neural_network.feedForward([[get_node("LeftSensor").left, get_node("RightSensor").right]])
	
	var np = NumpyHandmade.new()
	
	var max_value = x[0][0]
	var max_index = 0
	for i in range(len(x[0])):
		if x[0][i] > max_value:
			max_value = x[0][i]
			max_index = i
	
	dir = max_index
	
	#var vec = ["esquerda", "reto", "direita"]
	#print(vec[max_index])
