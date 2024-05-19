extends Node2D


func _ready():
	#var neural_network = NeuralNetwork.new([3, 6], ["Linear", "Softmax"])
	
	#neural_network.setWeightsBiases(1, [[-3.01417964072731, 2.23277594736469, -0.77682822566692], [-4.4259355145973, 1.46731932636143, 3.30831565978223], [0.20034748400113, -2.34880957381761, 4.67414443370881]], [1.33512963143754, -2.21212706834475, -2.19377693124152])
	#neural_network.setWeightsBiases(2, [[-0.99194913254301, 1.81640497910062, 3.07891716607935, -2.3488704741893, 0.41313318415326, -3.35584267332239], [0.27647775560941, -2.67752021757219, 0.30077039186701, 1.51215933960685, -1.43876119947948, 2.47237997859628], [-2.12092793245328, 0.09502438830827, -3.91331736376705, 2.84104948550668, 3.28265584249857, -0.23068982980301]], [1.29777693101548, 0.62283787420447, -0.26490822445362, -1.54243989293788, -0.22636955574299, -0.31155089432257])
	var X = [
		[0.33333333333333, 0.5, 0], # apple
		[0.3, 0.5, 0], # apple
		[0.28, 0.53, 0.02], # apple
		[0.33, 0.48, 0.03], # apple
		
		[0.33333333333333, 0.25, 0.33333333333333], # banana
		[0.3, 0.25, 0.3], # banana
		[0.27, 0.27, 0.31], # banana
		[0.33, 0.22, 0.28], # banana
		
		[0.33333333333333, 0, 0], # grapes
		[0.3, 0, 0], # grapes
		[0.31, 0.03, 0.04], # grapes
		[0.28, 0.03, 0.04], # grapes
		
		[1, 1, 1], # bread
		[0.98, 0.94, 1], # bread
		[0.97, 1, 0.99], # bread
		
		[0, 0.75, 0.66666666666667], # milk
		[0, 0.75, 0.6], # milk
		[0, 0.78, 0.58], # milk
		[0, 0.73, 0.63], # milk
		
		[0.66666666666667, 0.75, 0], # egg
		[0.6, 0.75, 0], # egg
		[0.63, 0.78, 0], # egg
		[0.58, 0.73, 0], # egg
		
		[0, 0, 0], # grape
		[0.1, 0.03, 0.4], # grape
		
		[0.66666666666667, 0.50, 0.66666666666667], # apple
		[0.6, 0.51, 0.7], # apple
		
		[1, 0.75, 1], # bread
		[0.97, 0.76, 0.95] # bread
	]
	var y = [
		[1, 0, 0, 0, 0, 0], #apple
		[1, 0, 0, 0, 0, 0], #apple
		[1, 0, 0, 0, 0, 0], #apple
		[1, 0, 0, 0, 0, 0], #apple
		
		[0, 1, 0, 0, 0, 0], #banana
		[0, 1, 0, 0, 0, 0], #banana
		[0, 1, 0, 0, 0, 0], #banana
		[0, 1, 0, 0, 0, 0], #banana
		
		[0, 0, 1, 0, 0, 0], #grapes
		[0, 0, 1, 0, 0, 0], #grapes
		[0, 0, 1, 0, 0, 0], #grapes
		[0, 0, 1, 0, 0, 0], #grapes
		
		[0, 0, 0, 1, 0, 0], #bread
		[0, 0, 0, 1, 0, 0], #bread
		[0, 0, 0, 1, 0, 0], #bread
		
		[0, 0, 0, 0, 1, 0], #milk
		[0, 0, 0, 0, 1, 0], #milk
		[0, 0, 0, 0, 1, 0], #milk
		[0, 0, 0, 0, 1, 0], #milk
		
		[0, 0, 0, 0, 0, 1], #egg
		[0, 0, 0, 0, 0, 1], #egg
		[0, 0, 0, 0, 0, 1], #egg
		[0, 0, 0, 0, 0, 1], #egg
		
		[0, 0, 1, 0, 0, 0], #grapes
		[0, 0, 1, 0, 0, 0], #grapes
		
		[1, 0, 0, 0, 0, 0], #apple
		[1, 0, 0, 0, 0, 0], #apple
		
		[0, 0, 0, 1, 0, 0], #bread
		[0, 0, 0, 1, 0, 0] #bread		
	]
	
	var Xt = [
		[0.33333333333333, 0.5, 0], # apple
		[0.33333333333333, 0.25, 0.33333333333333], # banana
		[0.33333333333333, 0, 0], # grapes
		[1, 1, 1], # bread
		[0, 0.75, 0.66666666666667], # milk
		[0.66666666666667, 0.75, 0] # egg
	]
	var yt = [
		[1, 0, 0, 0, 0, 0], #apple
		[0, 1, 0, 0, 0, 0], #banana
		[0, 0, 1, 0, 0, 0], #grapes
		[0, 0, 0, 1, 0, 0], #bread
		[0, 0, 0, 0, 1, 0], #milk
		[0, 0, 0, 0, 0, 1] #egg

		
	]
	#neural_network.train(X, y, 100, 0.1)
	
	#print(neural_network.accuracyTest(X, y))
	#print(neural_network.feedForward(X))
	var neural_network = NeuralNetwork.new([3, 6], ["Linear", "Softmax"])
	while neural_network.accuracyTest(X, y) != 1:
		neural_network = NeuralNetwork.new([3, 6], ["Linear", "Softmax"])
		neural_network.train(X, y, 300, 0.05)
		print(neural_network.accuracyTest(X, y))
	print(neural_network.accuracyTest(X, y))
	
	for i in range(len(neural_network.layers)):
		print("nn.setWeightsBiases(", i+1,", ", neural_network.layers[i].weights, ", ", neural_network.layers[i].biases, ")")

	print(neural_network.feedForward(Xt))
