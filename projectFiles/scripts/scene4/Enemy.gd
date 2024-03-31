extends CharacterBody2D

var map
var enemyPosIndex = Vector2(7, 7)
var goalPos

var pf

var timer = 0.2

func _ready():
	map = get_parent().map
	
	
	pf = Pathfinder.new(map)
	
	updatePos(enemyPosIndex.x, enemyPosIndex.y)
	
	pf.setStartGoal(enemyPosIndex, get_parent().player.playerPosIndex)
	pf.setAllCosts()

func _process(delta):
	timer -= delta

	if pf.goalReached and timer <= 0:
		if pf.nodes[enemyPosIndex.x][enemyPosIndex.y].path == true:
			pf.nodes[enemyPosIndex.x][enemyPosIndex.y].path = false
			print("sex")
		
		if enemyPosIndex.y > 0 and pf.nodes[enemyPosIndex.x][enemyPosIndex.y-1].path == true:
				enemyPosIndex.y -= 1
				#print("cima")
		
		elif enemyPosIndex.y < map.height - 1 and pf.nodes[enemyPosIndex.x][enemyPosIndex.y+1].path == true:
				enemyPosIndex.y += 1
				#print("baixo")
		
		elif enemyPosIndex.x > 0 and pf.nodes[enemyPosIndex.x-1][enemyPosIndex.y].path == true:
				enemyPosIndex.x -= 1
				#print("esquerda")

		elif enemyPosIndex.x < map.width - 1 and pf.nodes[enemyPosIndex.x+1][enemyPosIndex.y].path == true:
				enemyPosIndex.x += 1
				#print("direita")
				
		updatePos(enemyPosIndex.x, enemyPosIndex.y)
		timer = 0.5
	
	#move_and_slide()

func updatePos(i, j):
	position = Vector2(pf.nodes[i][j].position) + Vector2(pf.nodes[i][j].size/2, pf.nodes[i][j].size/2)

