class_name Activation_Softmax

var output = []

func forward(inputs):
	var max_input = -INF  # Definindo o máximo como o menor número possível

	# Encontrando o máximo
	for val in inputs:
		for x in val:
			max_input = max(max_input, x)

	var exp_values = []

	# Calculando as exponenciais e subtraindo o máximo
	for val in inputs:
		var exp_val = []
		for x in val:
			exp_val.append(exp(x - max_input))
		exp_values.append(exp_val)

	# Normalização das probabilidades
	var probabilities = []
	for exp_val in exp_values:
		var sum_exp_val = 0
		for x in exp_val:
			sum_exp_val += x
		var prob_val = []
		for x in exp_val:
			prob_val.append(x / sum_exp_val)
		probabilities.append(prob_val)
	
	self.output = probabilities
