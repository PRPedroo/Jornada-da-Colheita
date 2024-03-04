class_name NeuralNetwork

var inputs : Array
var output : Array

var layers : Array
var activations : Array

func _init(inOut : Array, sizeLayers : Array, activationFunctions):
	var out = []
	for i in range(inOut[1]):
		out.append(0)
	output.append(out)
	layers.append(Layer.new(inOut[0], sizeLayers[0]))
	sizeLayers.pop_front()
	if sizeLayers.size() > 1:
		for i in sizeLayers:
			layers.append(Layer.new(inOut[i], sizeLayers[i+1]))
	else:
		layers.append(Layer.new(sizeLayers[0], inOut[1]))
	for i in activationFunctions:
		if "ReLU" == i:
			self.activations.append(Activation_ReLU.new())
		elif "Softmax" == i:
			self.activations.append(Activation_Softmax.new())

func setWeightsBiases(layer, weights, biases):
	layers[layer-1].weights = weights
	layers[layer-1].biases = biases
	
func feedForward(inputs : Array):
	for i in range(len(layers)):
		if 0 == i:
			layers[i].forward(inputs)
		else:
			var input = activations[i-1].output
			layers[i].forward(input)
		activations[i].forward(layers[i].output)
	self.output = activations[activations.size()-1].output
	return activations[activations.size()-1].output

func backPropagation(inputs, outputs, targets):
	var np = NumpyHandmade.new()
	
	var first = []
	for i in range(len(outputs)):
		var aux = []
		for j in range(len(outputs[0])):
			aux.append(0)
		first.append(aux)
	
	for i in range(len(first)):
		for j in range(len(first[0])):
			first[i][j] = outputs[i][j] - targets[i][j]
	
	var dz = [first]
	#print(outputs, "\n\n")
	#print(targets, "\n\n")
	#print(dz)
	for i in range(len(layers) - 1, 0, -1):
		dz.insert(0, np.star(np.dot(dz[0], np.T(layers[i].weights)), activations[i-1].derivative(layers[i-1].output)))
		# TENHO QUASE CTZ Q É AQUI O ERRO !!!!!
	#for i in range(2):
		#print(dz[i], "\n\n\n")
	var weight_updates = []
	var biases_updates = []
	var m : float
	m = 1 / float(len(self.output[0]))
	
	for i in range(len(layers)):
		weight_updates.append(np.times(m, np.dot(np.T(dz[i]), layers[i].input)))
		biases_updates.append(np.timesFloatVec(m, np.sumMat(dz[i])))
	return [weight_updates, biases_updates]

func train(X, y, epoch, learning_rate):
	var np = NumpyHandmade.new()
	var weight_updates
	var biases_updates
	for i in range(epoch):
		# Feedforward
		var outputs = feedForward(X)
		#print(outputs, "\n\n")
		
		# Backpropagation
		
		var biasWeight = backPropagation(X, outputs, y)
		
		weight_updates = biasWeight[0]
		biases_updates = biasWeight[1]
		
		# Atualização dos pesos
		for j in range(len(layers)):
			#print(layers[j].weights, "\n\n")
			var first = []
			for k in range(len(layers[j].weights)):
				var aux = []
				for l in range(len(layers[j].weights[0])):
					aux.append(0)
				first.append(aux)

			for k in range(len(first)):
				for l in range(len(first[0])):
					first[k][l] = layers[j].weights[k][l] - np.times(learning_rate, np.T(weight_updates[j]))[k][l]
			
			layers[j].weights = first
			
			layers[j].biases = np.minusVec(layers[j].biases, np.timesFloatVec(learning_rate, biases_updates[j]))
			#print(layers[j].weights, "\n\n")
