class_name Activation_Softmax extends ActivationFunction

func forward(inputs):
	var maxInput = -INF  # Definindo o máximo como o menor número possível

	# Encontrando o máximo
	for val in inputs:
		for i in val:
			maxInput = max(maxInput, i)
	var expValues = []

	# Calculando as exponenciais e subtraindo o máximo
	for val in inputs:
		var expVal = []
		for x in val:
			expVal.append(exp(x - maxInput))
		expValues.append(expVal)

	# Normalização das probabilidades
	var probabilities : Array
	for expVal in expValues:
		var sumExpVal = 0
		for i in expVal:
			sumExpVal += i
		var probVal : Array
		for i in expVal:
			probVal.append(i / sumExpVal)
		probabilities.append(probVal)
	self.output = probabilities
	
	return self.output

func derivative(inputs):
	var np = NumpyHandmade.new()
	var exp_z = []
	var sum_exp_z = 0.0
	var softmax_z = []
	var softmax_deriv = []
	
	# Calcula o softmax
	for val in inputs:
		for i in range(len(val)):
			val[i] = exp(val[i])
		exp_z.append(val)
		sum_exp_z += np.sum(val)
	for val in exp_z:
		for i in range(len(val)):
			val[i] = val[i]/sum_exp_z
		softmax_z.append(val)

	# Calcula a derivada do softmax
	for i in range(inputs.size()):
		softmax_deriv.append(np.timesVec(softmax_z[i], (np.invert(softmax_z[i]))))

	return softmax_deriv
