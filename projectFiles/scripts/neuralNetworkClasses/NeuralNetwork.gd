class_name NeuralNetwork

var inputs : Array
var output : Array

var layers : Array
var activations : Array

func _init(sizeLayers : Array, activationFunctions : Array):
	var outputAux = []
	for i in range(sizeLayers[(sizeLayers.size())-1]):
		outputAux.append(0)
	output.append(outputAux)
	layers.append(Layer.new(sizeLayers[0], sizeLayers[0]))
	for i in range(len(sizeLayers)-1):
			layers.append(Layer.new(sizeLayers[i], sizeLayers[i+1]))
	
	for i in activationFunctions:
		if "ReLU" == i:
			self.activations.append(Activation_ReLU.new())
		elif "Softmax" == i:
			self.activations.append(Activation_Softmax.new())
		elif "Linear" == i:
			self.activations.append(Activation_Linear.new())

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
	
	var dz0 = []
	for i in range(len(outputs)):
		var aux = []
		for j in range(len(outputs[0])):
			aux.append(0)
		dz0.append(aux)
	
	for i in range(len(dz0)):
		for j in range(len(dz0[0])):
			dz0[i][j] = outputs[i][j] - targets[i][j]
	
	var dz = [dz0]
	for i in range(len(layers) - 1, 0, -1):
		dz.insert(0, np.star(np.dot(dz[0], np.T(layers[i].weights)), activations[i-1].derivative(layers[i-1].output)))
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
		
		# FEEDFORWARD
		var outputs = feedForward(X)
		
		# BACKPROPAGATION
		var biasWeight = backPropagation(X, outputs, y)
		
		weight_updates = biasWeight[0]
		biases_updates = biasWeight[1]
		
		
		# ATUALIZA OS PESOS E VIESES
		for j in range(len(layers)):
			var weightsUpdated = []
			
			# ENCHE A MATRIZ DE 0 NO TAMANHO ADEQUADO
			for k in range(len(layers[j].weights)):
				var aux = []
				for l in range(len(layers[j].weights[0])):
					aux.append(0)
				weightsUpdated.append(aux)

			for k in range(len(weightsUpdated)):
				for l in range(len(weightsUpdated[0])):
					weightsUpdated[k][l] = layers[j].weights[k][l] - np.times(learning_rate, np.T(weight_updates[j]))[k][l]
			
			layers[j].weights = weightsUpdated
			
			layers[j].biases = np.minusVec(layers[j].biases, np.timesFloatVec(learning_rate, biases_updates[j]))

func accuracyTest(X, y):
	var np = NumpyHandmade.new()
	
	var predictions = np.argmax(self.feedForward(X)) # OBTÉM O ÍNDICE DO VALOR MÁXIMO
	var true_labels = np.argmax(y) # OBTÉM O ÍNDICE DO VALOR MÁXIMO
	var accuracy : float = 0.0
	
	print(predictions, "\n\n", true_labels)
	for i in range(len(true_labels)):
		if predictions[i] == true_labels[i]:
			accuracy += 1
	accuracy = accuracy / len(true_labels)  # CALCULA A PRECISÃO
	
	return accuracy
