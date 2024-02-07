class_name Layer_Dense

var weights
var biases
var output = []

func initialize(weights, biases):
	self.weights = weights
	self.biases = biases

func forward(inputs):
	var A = inputs
	var B = self.weights 
	var C = []
	
	var rows_A = len(A)
	var cols_A = len(A[0])
	var rows_B = len(B)
	var cols_B = len(B[0])
	
	var aux = []
	for i in range(cols_B):
		aux.append(0)
	for i in range(rows_A):
		C.append(aux)
		
	if cols_A != rows_B:
		print("erro")
		return
	#create the result matrix 
	
	for i in range(rows_A):
		for j in range(cols_B):
			for k in range(cols_A):
				C[i][j] += A[i][k] * B[k][j] 
	self.output = C
	for i in range(rows_A):
		for j in range(cols_B):
			self.output[i][j] = C[i][j] + self.biases[j]
