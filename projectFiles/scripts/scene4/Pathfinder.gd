class_name Pathfinder

var startIndex
var goalIndex

var currentNode

var nodes = []
var openNodes = []
var checkedNodes = []

var goalReached = false

var np = NumpyHandmade.new()

func _init(_map):
	self.nodes = _map.duplicateNodes()
	
func setStartGoal(_startIndex, _goalIndex):
	self.startIndex = _startIndex
	self.goalIndex = _goalIndex
	self.currentNode = nodes[_startIndex.x][_startIndex.y]
	
func setAllCosts():
	for i in range(len(nodes)):
		for j in range(len(nodes[0])):
			calculateCosts(nodes[i][j], Vector2(i, j))

func calculateCosts(node, index):
	node.costG = np.abs(index.x - startIndex.x) +  np.abs(index.y - startIndex.y)
	node.costH = np.abs(index.x - goalIndex.x) +  np.abs(index.y - goalIndex.y)
	
	node.costF = node.costG + node.costH
	
func search():
	while !goalReached:
		var current = currentNode
		
		current.setChecked()
		checkedNodes.append(current)
		openNodes.erase(current)
		
		if current.index.y - 1 >= 0:
			openNode(nodes[current.index.x][current.index.y - 1])
		if current.index.x - 1 >= 0:
			openNode(nodes[current.index.x - 1][current.index.y])
		if current.index.y < len(nodes[0]) - 1:
			openNode(nodes[current.index.x][current.index.y + 1])
		if current.index.x < len(nodes) - 1:
			openNode(nodes[current.index.x + 1][current.index.y])
	
		var bestNodeIndex = 0
		var bestNodeCost = 999
	
		for i in range(len(openNodes)):
			if openNodes[i].costF < bestNodeCost:
				bestNodeIndex = i
				bestNodeCost = openNodes[i].costF
			elif openNodes[i].costF == bestNodeCost:
				if openNodes[i].costG < openNodes[bestNodeIndex].costG:
					bestNodeIndex = i
		
		currentNode = openNodes[bestNodeIndex]
		
		if currentNode.index == goalIndex:
			goalReached = true
			trackPath()
	
func openNode(node):
	if !node.open and !node.checked and !node.wall:
		node.setOpen()
		node.parent = currentNode
		openNodes.append(node)

func trackPath():
	var current = nodes[goalIndex.x][goalIndex.y]
	
	while current != nodes[startIndex.x][startIndex.y]:
		current = current.parent
		current.setPath()
		
func resetAll():
	goalReached = false
	openNodes.clear()
	checkedNodes.clear()
	for i in nodes:
		for j in i:
			j.open = false
			j.checked = false
			j.path = false
			j.parent = null
