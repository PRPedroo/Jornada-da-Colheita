extends Node2D


func _ready():
	var neural_network = NeuralNetwork.new([2, 2], ["Linear", "Softmax"])
	#neural_network.setWeightsBiases(1, [[rng.randf_range(0.1, 0.9) * rng.randf_range(-1, 1), rng.randf_range(0.1, 0.9) * rng.randf_range(-1, 1)], [rng.randf_range(0.1, 0.9) * rng.randf_range(-1, 1), rng.randf_range(0.1, 0.9) * rng.randf_range(-1, 1)]], [rng.randf_range(0.1, 0.9) * rng.randf_range(-1, 1), rng.randf_range(0.1, 0.9) * rng.randf_range(-1, 1)])
	#neural_network.setWeightsBiases(2, [[rng.randf_range(0.1, 0.9) * rng.randf_range(-1, 1), rng.randf_range(0.1, 0.9) * rng.randf_range(-1, 1)], [rng.randf_range(0.1, 0.9) * rng.randf_range(-1, 1), rng.randf_range(0.1, 0.9) * rng.randf_range(-1, 1)]], [rng.randf_range(0.1, 0.9) * rng.randf_range(-1, 1), rng.randf_range(0.1, 0.9) * rng.randf_range(-1, 1)])

	var X = [
		[0, 1], ## DIREITA
		[1, 0], ## ESQUERDA
		[1, 1], ## ESQUERDA
		[0, 0], ## ESQUERDA
		[1, -1], ## ESQUERDA
		[0.1, -1], ## ESQUERDA
		[-1, 1], ## DIREITA
		[-0.7, 0.2], ## DIREITA
		[-0.9, 0.1], ## DIREITA
		[0.5, -1], ## ESQUERDA
		[-0.1, 0.7], ## DIREITA
		[0.5, 0.8], ## DIREITA
		[0.1, 0.2], ## DIREITA
		[0.2, 0.1], ## ESQUERDA
		[0.8, 0.5] ## ESQUERDA
	]
	var y = [
		[0, 1],
		[1, 0],
		[1, 0],
		[1, 0],
		[1, 0],
		[1, 0],
		[0, 1],
		[0, 1],
		[0, 1],
		[1, 0],
		[0, 1],
		[0, 1],
		[0, 1],
		[1, 0],
		[1, 0]
	]
	neural_network.train(X, y, 100, 0.1)
	
	print(neural_network.accuracyTest(X, y))
	print(neural_network.feedForward(X))
	
	for i in range(len(neural_network.layers)):
		print("neural_network.setWeightsBiases(", i+1,", ", neural_network.layers[i].weights, ", ", neural_network.layers[i].biases, ")")
