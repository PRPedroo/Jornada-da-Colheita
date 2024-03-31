extends Node2D

@onready var screen = $screen

var player
var enemy

var playerPos = Vector2(0, 0)

var font 

var map = Map.new(Vector2(-287, -92), 10, 17, Vector2(29, 10))

func _ready():
	font = FontFile.new()
	font.font_data = load("res://fonts/Next Sunday.ttf")
	
	map.generateMap(Vector2(574*2, 324*2))
	map.setWalls()
	queue_redraw()
	
	var load = load("res://objects/scene4/player.tscn")
	player = load.instantiate()
	add_child(player)
	
	load = load("res://objects/scene4/enemy.tscn")
	enemy = load.instantiate()
	add_child(enemy)
	
func _process(_delta):
	queue_redraw()
	#print(map.nodes[3][3].costF)
	pass
	
func changePlayerPos(value):
	playerPos = value
	enemy.pf.resetAll()
	enemy.pf.setStartGoal(enemy.enemyPosIndex, playerPos)
	enemy.pf.setAllCosts()
	enemy.pf.search()

func _draw():
	for i in enemy.pf.nodes:
		for j in i:
			if j.wall:
				draw_rect(Rect2(Vector2(j.position),Vector2(j.size, j.size)),Color(0, 0, 0, 1))
			elif j.path:
				draw_rect(Rect2(Vector2(j.position),Vector2(j.size, j.size)),Color(0.3, 0.2, 0.6, 1))
			elif j.checked:
				draw_rect(Rect2(Vector2(j.position),Vector2(j.size, j.size)),Color(0.3, 1, 0, 1))
			elif j.open:
				draw_rect(Rect2(Vector2(j.position),Vector2(j.size, j.size)),Color(0.8, 0.3, 0.2, 1))
			else:
				draw_rect(Rect2(Vector2(j.position),Vector2(j.size, j.size)),Color(1, 1, 1, 1))
	'''
	for i in enemy.pf.nodes:
		for j in i:
			draw_string(font, Vector2(j.position.x, j.position.y+10), str("F: ", str(j.costF)), 0, -1, 10, Color(0, 0, 0, 1.0))
			draw_string(font, Vector2(j.position.x, j.position.y+20), str("G: ", str(j.costG)), 0, -1, 10, Color(0, 0, 0, 1.0))
	'''
