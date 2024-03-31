extends CharacterBody2D

var map
var playerPosIndex = Vector2(14, 2)

func _ready():
	map = get_parent().map
	updatePos(playerPosIndex.x, playerPosIndex.y)

func _physics_process(_delta):
	if Input.is_action_just_pressed("up"):
		if playerPosIndex.y > 0:
			if !map.nodes[playerPosIndex.x][playerPosIndex.y-1].wall:
				playerPosIndex.y -= 1
				emitSignal()
	if Input.is_action_just_pressed("down"):
		if playerPosIndex.y < map.height - 1:
			if !map.nodes[playerPosIndex.x][playerPosIndex.y+1].wall:
				playerPosIndex.y += 1
				emitSignal()
	if Input.is_action_just_pressed("left"):
		if playerPosIndex.x > 0:
			if !map.nodes[playerPosIndex.x - 1][playerPosIndex.y].wall:
				playerPosIndex.x -= 1
				emitSignal()
	if Input.is_action_just_pressed("right"):
		if playerPosIndex.x < map.width - 1:
			if !map.nodes[playerPosIndex.x + 1][playerPosIndex.y].wall:
				playerPosIndex.x += 1
				emitSignal()
	updatePos(playerPosIndex.x, playerPosIndex.y)
	#move_and_slide()

func updatePos(i, j):
	position = Vector2(map.nodes[i][j].position) + Vector2(map.nodes[i][j].size/2, map.nodes[i][j].size/2)

func emitSignal():
	get_parent().changePlayerPos(playerPosIndex)
