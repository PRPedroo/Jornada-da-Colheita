extends CharacterBody2D

var root
var map
var posIndex = Vector2(0, 0)
var goalPos

var pf

var speed = 1
var timer = speed

var stun = 0

@onready var audio = $AudioStreamPlayer2D

func _ready():
	root = get_parent().get_parent()
	map = root.map
	
	
	pf = Pathfinder.new(map)
	
	setPos(posIndex.x, posIndex.y)
	
	pf.setStartGoal(posIndex, root.player.posIndex)
	pf.setAllCosts()

func _process(delta):
	if !root.pause:
		if timer > 0:
			timer -= delta
		
		if stun > 0:
			stun -= delta
	
		move()

func updatePos(i, j):
	var newPos = Vector2(map.nodes[i][j].position) + Vector2(map.nodes[i][j].size/2, map.nodes[i][j].size/2)
	var tween = create_tween()
	tween.tween_property(self, "position", newPos, speed)

func setPos(i, j):
	position = Vector2(pf.nodes[i][j].position) + Vector2(pf.nodes[i][j].size/2, pf.nodes[i][j].size/2)

func checkGoal():
	if pf.nodes[posIndex.x][posIndex.y] == pf.nodes[pf.goalIndex.x][pf.goalIndex.y]:
		stun = 4
		root.player.stun(2)
		audio.play()

func move():
	if pf.goalReached and timer <= 0 and stun <= 0:
		if pf.nodes[posIndex.x][posIndex.y].path == true:
			pf.nodes[posIndex.x][posIndex.y].path = false
		
		if posIndex.y > 0 and pf.nodes[posIndex.x][posIndex.y-1].path == true:
				posIndex.y -= 1
				rotation_degrees = 90
		
		elif posIndex.y < map.height - 1 and pf.nodes[posIndex.x][posIndex.y+1].path == true:
				posIndex.y += 1
				rotation_degrees = 270
		
		elif posIndex.x > 0 and pf.nodes[posIndex.x-1][posIndex.y].path == true:
				posIndex.x -= 1
				rotation_degrees = 0

		elif posIndex.x < map.width - 1 and pf.nodes[posIndex.x+1][posIndex.y].path == true:
				posIndex.x += 1
				rotation_degrees = 180
				
		updatePos(posIndex.x, posIndex.y)
		checkGoal()
		timer = speed
