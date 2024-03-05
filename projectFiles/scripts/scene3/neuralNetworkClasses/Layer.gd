class_name Layer

var weights = []
var biases = []

var input : Array
var output : Array

# Inicializa a camada, caso os valores de pesos e vieses forem nulos ele inicializa com valores aleatórios
func _init(n_inputs, n_neurons):
	for i in range(n_inputs):
		var rowW = []
		for j in range(n_neurons):
			rowW.append(0.5 * randf_range(-1, 1))
		self.weights.append(rowW)
	for i in range(n_neurons):
		self.biases.append(0.5 * randf_range(-1, 1))

func forward(inputs):
	# Calcula o tamanho das matrizes a serem multiplicadas
	self.input = inputs
	var A = inputs
	var B = self.weights 
	#print(A, "\n\n", B)
	var np = NumpyHandmade.new()
	
	var C = np.dot(A, B)
	self.output = C
	
	# Atualiza o output somando os vieses
	for i in range(len(A)):
		for j in range(len(B[0])):
			self.output[i][j] = C[i][j] + self.biases[j]
	#print(self.output)
	return self.output
