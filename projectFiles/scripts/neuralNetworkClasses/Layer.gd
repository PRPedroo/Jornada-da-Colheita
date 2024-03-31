class_name Layer

var weights = []
var biases = []

var input : Array
var output : Array

# INICIALIZA A CAMADA COM PESOS E VIESES ALEATÓRIOS
func _init(n_inputs, n_neurons):
	for i in range(n_inputs):
		var rowW = []
		for j in range(n_neurons):
			rowW.append(0.5 * randf_range(-1, 1))
		self.weights.append(rowW)
	for i in range(n_neurons):
		self.biases.append(0.5 * randf_range(-1, 1))

func forward(inputs):
	# CALCULA O TAMANHO DAS MATRIZES A SERES MULTIPLICADAS
	self.input = inputs
	var A = inputs
	var B = self.weights 
	var np = NumpyHandmade.new()
	
	var C = np.dot(A, B)
	self.output = C
	
	# ATUALIZA O OUTPUT SOMANDO OS VIESES
	for i in range(len(A)):
		for j in range(len(B[0])):
			self.output[i][j] = C[i][j] + self.biases[j]
	
	return self.output
