class_name NodeP

var position
var index
var size

var costG = 0
var costH = 0
var costF = 0

var wall = false
var checked = false
var open = false
var path = false
var parent = null

func _init(_position, _index, _size):
	self.position = _position
	self.index = _index
	self.size = _size
	
func setWall():
	self.wall = true

func setOpen():
	self.open = true

func setChecked():
	checked = true
	
func setPath():
	path = true

func duplicate():
	var newNode = NodeP.new(self.position, self.index, self.size)
	newNode.wall = self.wall
	return newNode
