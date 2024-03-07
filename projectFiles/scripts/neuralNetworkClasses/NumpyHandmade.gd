class_name NumpyHandmade

func dot(A, B):
	var C = []
	
	var rows_A = len(A)
	var cols_A = len(A[0])
	var rows_B = len(B)
	var cols_B = len(B[0])
	
	for i in range(rows_A):
		var aux = []
		for j in range(cols_B):
			aux.append(0)
		C.append(aux)
	
	# Mostra um erro se nao for possível a multiplicação das matrizes
	if cols_A != rows_B:
		print("erro")
		return
	
	# Multiplica as matrizes de pesos e inputs
	for i in range(rows_A):
		for j in range(cols_B):
			for k in range(cols_A):
				C[i][j] += (A[i][k] * B[k][j])
	return C

func star(A, B):
	for i in range(len(A)):
		for j in range(len(A[0])):
			A[i][j] = A[i][j] * B[i][j]
	return A

func times(A : float, B : Array):
	for i in range(len(B)):
		for j in range(len(B[0])):
			B[i][j] *= A
	return B

func timesFloatVec(A : float, B : Array):
	for i in range(len(B)):
		B[i] *= A
	return B

func T(A):
	var C = []
	
	var rows_A = len(A)
	var cols_A = len(A[0])
	
	for i in range(cols_A):
		var aux = []
		for j in range(rows_A):
			aux.append(A[j][i])
		C.append(aux)

	return C

func minusMat(A, B):
	var C = A
	for i in range(len(A)):
		for j in range(len(A[0])):
			C[i][j] = A[i][j] - B[i][j]
	return C

func plusMat(A, B):
	for i in range(len(A)):
		for j in range(len(A[0])):
			A[i][j] = A[i][j] + B[i][j]
	return A

func sumMat(A):
	var sum = []
	var aux = 0
	for j in range(len(A[0])):
		for i in range(len(A)):
			aux += A[i][j]
		sum.append(aux)
		aux = 0
	return sum
	
func sum(A):
	var sum = 0.0
	for i in range(len(A)):
		sum += A[i]
	return sum

func invert(A):
	for i in range(len(A)):
		A[i] = 1 - A[i]
	return A
	
func timesVec(A, B):
	for i in range(len(A)):
		A[i] = A[i] * B[i]
	return A

func plusVec(A, B):
	for i in range(len(A)):
		A[i] = A[i] + B[i]
	return A

func minusVec(A, B):
	for i in range(len(A)):
		A[i] = A[i] - B[i]
	return A

func argmax(A):
	var indexes = []
	for i in range(len(A)):
		var big = A[i][0]
		var index = 0
		for j in range(len(A[0])):
			if A[i][j] > A[i][big]:
				big = A[i][j]
				index = j
		indexes.append(index)
	return indexes
