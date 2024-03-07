class_name Activation_Linear extends ActivationFunction

func forward(inputs):
	var in_rows = len(inputs)
	var in_cols = len(inputs[0])
	
	var C : Array
	
	# Preenche o vetor C (output) com zeros
	for i in range(in_rows):
		var aux = []
		for j in range(in_cols):
			aux.append(0)
		C.append(aux)
		
	self.output = C
	
	# Preenche com os valores da função ReLU (0 se for menor que 0 e o valor respectivo se for maior que 0)
	for i in range(in_rows):
		for j in range(in_cols):
			self.output[i][j] = inputs[i][j]
	return self.output

func derivative(inputs):
	var in_rows = len(inputs)
	var in_cols = len(inputs[0])
	
	var C = []
	var aux = []
	
	# Preenche o vetor C (output) com zeros
	for i in range(in_cols):
		aux.append(0)
	for i in range(in_rows):
		C.append(aux)
		
	# Calcula a derivada da função ReLU
	for i in range(in_rows):
		for j in range(in_cols):
				C[i][j] = 1
				
	return C
