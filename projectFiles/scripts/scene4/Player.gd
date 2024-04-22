extends CharacterBody2D

@onready var ap = $AnimationPlayer

var root
var map
var posIndex = Vector2(0, 0)

var timer = 0
var goal

var stunned = false
var speed = 0.2

func _ready():
	root = get_parent().get_parent()
	map = root.map
	updatePos(posIndex.x, posIndex.y)

func _physics_process(delta):
	if timer <= 0:
		move()
		updatePos(posIndex.x, posIndex.y)
		stunned = false
	else:
		if stunned:
			print("stuned")
		timer -= delta
	checkItem()

func stun(time):
	timer = time
	stunned = true

func checkItem():
	if map.nodes[posIndex.x][posIndex.y].item != null:
		if map.nodes[posIndex.x][posIndex.y].item.itemName == goal:
			root.instantiateItems()
		else:
			map.nodes[posIndex.x][posIndex.y].item.remove()
			map.nodes[posIndex.x][posIndex.y].item = null

func move():
	if Input.is_action_pressed("up"):
		if posIndex.y > 0:
			if !map.nodes[posIndex.x][posIndex.y-1].wall and Vector2(posIndex.x, posIndex.y-1):# != root.enemy.posIndex:
				posIndex.y -= 1
				emitSignal()
				timer = speed
				rotation_degrees = 90
				
	elif Input.is_action_pressed("down"):
		if posIndex.y < map.height - 1:
			if !map.nodes[posIndex.x][posIndex.y+1].wall and Vector2(posIndex.x, posIndex.y+1):# != root.enemy.posIndex:
				posIndex.y += 1
				emitSignal()
				timer = speed
				rotation_degrees = 270
				
	elif Input.is_action_pressed("left"):
		if posIndex.x > 0:
			if !map.nodes[posIndex.x - 1][posIndex.y].wall and Vector2(posIndex.x-1, posIndex.y):# != root.enemy.posIndex:
				posIndex.x -= 1
				emitSignal()
				timer = speed
				rotation_degrees = 0

	elif Input.is_action_pressed("right"):
		if posIndex.x < map.width - 1:
			if !map.nodes[posIndex.x + 1][posIndex.y].wall and Vector2(posIndex.x+1, posIndex.y):# != root.enemy.posIndex:
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
