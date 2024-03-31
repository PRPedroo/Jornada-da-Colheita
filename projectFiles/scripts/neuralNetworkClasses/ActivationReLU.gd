class_name Activation_ReLU extends ActivationFunction

func forward(inputs):
	var in_rows = len(inputs)
	var in_cols = len(inputs[0])
	
	var C : Array
	
	# ENCHE A MATRIZ C COM ZEROS, NO TAMANHO ADEQUADO
	for i in range(in_rows):
		var aux = []
		for j in range(in_cols):
			aux.append(0)
		C.append(aux)
		
	self.output = C
	
	# PREENCHE O VETOR OUTPUT COM VALORES DA FUNÇÃO RELU
	# (0 SE FOR MENOR QUE 0 E O VALOR RESPECTIVO SE FOR MAIOR QUE 0)
	for i in range(in_rows):
		for j in range(in_cols):
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
	
	# ENCHE A MATRIZ C COM ZEROS, NO TAMANHO ADEQUADO
	for i in range(in_cols):
		aux.append(0)
	for i in range(in_rows):
		C.append(aux)
		
	# DERIVADA RELU
	for i in range(in_rows):
		for j in range(in_cols):
			if inputs[i][j] > 0:
				C[i][j] = inputs[i][j]
			else:
				C[i][j] = 0
				
	return C
