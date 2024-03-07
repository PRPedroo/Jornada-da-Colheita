class_name Activation_ReLU extends ActivationFunction

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
			#print(self.output)
			if inputs[i][j] > 0:
				self.output[i][j] = inputs[i][j]
			else:
				self.output[i][j] = 0
				
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
			if inputs[i][j] > 0:
				C[i][j] = inputs[i][j]
			else:
				C[i][j] = 0
				
	return C
