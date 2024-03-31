class_name Activation_Linear extends ActivationFunction

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
	
	# PREENCHE COM OS VALORES DA FUNÇÃO LINEAR (F(X) = X)
	for i in range(in_rows):
		for j in range(in_cols):
			self.output[i][j] = inputs[i][j]
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
		
	# LINEAR DERIVADA
	for i in range(in_rows):
		for j in range(in_cols):
				C[i][j] = 1
				
	return C
