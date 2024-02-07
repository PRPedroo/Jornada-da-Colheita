class_name Activation_ReLU

var output

func forward(inputs):
	var in_rows = len(inputs)
	var in_cols = len(inputs[0])
	
	var C = []
	var aux = []
	for i in range(in_cols):
		aux.append(0)
	for i in range(in_rows):
		C.append(aux)
		
	self.output = C
	
	for i in range(in_rows):
		for j in range(in_cols):
			if inputs[i][j] > 0:
				self.output[i][j] = inputs[i][j]
			else:
				self.output[i][j] = 0
