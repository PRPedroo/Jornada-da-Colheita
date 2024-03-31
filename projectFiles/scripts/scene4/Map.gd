class_name Map

var initialPos
var height
var width
var offset

var nodes = []
var nodesBitMap = []

# Called when the node enters the scene tree for the first time.
func _init(_initialPos, _height, _width, _offset):
	self.initialPos = _initialPos
	self.height = _height
	self.width = _width
	self.offset = _offset

func generateMap(screensize:Vector2):
	var spacerX = (screensize.x/width) - 4*offset.x/width
	var spacerY = (screensize.y/height) - 4*offset.y/height
	
	for i in range(width):
		var vec = []
		for j in range(height):
			var nodePos = Vector2(initialPos.x + (i * spacerX/2) + offset.x, initialPos.y + (j * spacerY/2) + offset.y) 
			var aux : NodeP = NodeP.new(nodePos, Vector2(i, j), spacerX/2)
			vec.append(aux)
		nodes.append(vec)

func duplicateNodes():
	var newNodes = []
	for i in self.nodes:
		var aux = []
		for j in i:
			aux.append(j.duplicate())
		newNodes.append(aux)
	return newNodes

func setWalls():
	nodes[3][1].setWall()
	nodes[3][2].setWall()
	nodes[3][3].setWall()
	
	nodes[3][6].setWall()
	nodes[3][7].setWall()
	nodes[3][8].setWall()
	
	nodes[8][1].setWall()
	nodes[8][2].setWall()
	nodes[8][3].setWall()
	
	nodes[8][6].setWall()
	nodes[8][7].setWall()
	nodes[8][8].setWall()

	nodes[13][1].setWall()
	nodes[13][2].setWall()
	nodes[13][3].setWall()
	
	nodes[13][6].setWall()
	nodes[13][7].setWall()
	nodes[13][8].setWall()
