extends CharacterBody2D

@onready var ap = $AnimationPlayer
@onready var audio = $AudioStreamPlayer2D
@onready var sprite = $Sprite2D

var root
var map
var posIndex
var points = 0

var timer = 0
var goal

var stunned = false
var speed = 0.2

var nn = NeuralNetwork.new([3, 6], ["Linear", "Softmax"])
var np = NumpyHandmade.new()
var items = ["apple", "banana", "grapes", "bread", "milk", "egg"]

var timerDif = 0

func _ready():
	root = get_parent().get_parent()
	map = root.map
	updatePos(posIndex.x, posIndex.y)
	
	nn.setWeightsBiases(1, [[-0.78465057186338, -1.25180528750293, 3.26778962805252], [3.0649940127872, -0.8305950798914, 2.39186422521121], [2.79296714108954, 1.03970982321916, -1.07043174742395]], [-1.7445925895947, 1.91484698938836, -0.91303756158317])
	nn.setWeightsBiases(2, [[-0.04765651790414, -0.38188301647399, -2.92044591346496, 2.20961269490241, 2.55662316903759, -0.78614734714317], [0.5420325578497, 1.08132281432645, 0.48411371855893, -1.35657216230628, 0.38432320823619, -1.99930932780767], [1.14631518401544, -0.70314319897412, -2.19349844513572, 1.50006857947525, -1.72568894097505, 2.59417100046738]], [0.51200038738093, 0.94827164485346, 0.0755777908751, -1.79798785184366, -0.30503911405801, -0.42067961408139])

func _physics_process(delta):
	if !root.pause:
		if timer <= 0:
			move()
			updatePos(posIndex.x, posIndex.y)
			stunned = false
		
		if stunned:
			ap.stop()
			sprite.frame = 2
		else:
			ap.play("moving")
		timer -= delta
		checkItem()
		
		timerDif -= delta

func stun(time):
	timer = time
	stunned = true

func checkItem():
	if map.nodes[posIndex.x][posIndex.y].item != null:
		audio.play()
		var output = nn.feedForward([map.nodes[posIndex.x][posIndex.y].item.getTraits()])
		var guess = items[np.argmax(output)[0]]
		if guess == goal:
			if timerDif > 0 and root.get_parent().difficultyFase4 < 5:
				root.get_parent().difficultyFase4 += 1
			elif timerDif < -2 and root.get_parent().difficultyFase4 > 0:
				root.get_parent().difficultyFase4 -= 1
			points += 1
			if points == 8:
				root.endGame()
			root.instantiateItems()
		else:
			map.nodes[posIndex.x][posIndex.y].item.remove()
			map.nodes[posIndex.x][posIndex.y].item = null

func move():
	if Input.is_action_pressed("up"):
		if posIndex.y > 0:
			if !map.nodes[posIndex.x][posIndex.y-1].wall:# != root.enemy.posIndex:
				posIndex.y -= 1
				emitSignal()
				timer = speed
				rotation_degrees = 90
				
	elif Input.is_action_pressed("down"):
		if posIndex.y < map.height - 1:
			if !map.nodes[posIndex.x][posIndex.y+1].wall:# != root.enemy.posIndex:
				posIndex.y += 1
				emitSignal()
				timer = speed
				rotation_degrees = 270
				
	elif Input.is_action_pressed("left"):
		if posIndex.x > 0:
			if !map.nodes[posIndex.x - 1][posIndex.y].wall:# != root.enemy.posIndex:
				posIndex.x -= 1
				emitSignal()
				timer = speed
				rotation_degrees = 0

	elif Input.is_action_pressed("right"):
		if posIndex.x < map.width - 1:
			if !map.nodes[posIndex.x + 1][posIndex.y].wall:# != root.enemy.posIndex:
				posIndex.x += 1
				emitSignal()
				timer = speed
				rotation_degrees = 180

func emitSignal():
	root.changePlayerPos(posIndex)

func updatePos(i, j):
	var newPos = Vector2(map.nodes[i][j].position) + Vector2(map.nodes[i][j].size/2, map.nodes[i][j].size/2)
	var tween = create_tween()
	tween.tween_property(self, "position", newPos, speed)
