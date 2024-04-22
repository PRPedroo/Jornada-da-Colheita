extends Node2D

@onready var screen = $screen
@onready var goal_sprite = $Camera2D/HUD/Sprite2D

var player
var enemyFollow
var enemyRandom
var enemyGoal

var tiles = []
@export var texture : Texture2D:
	set(value):
		texture = value

var playerPos = Vector2(0, 0)

var font

var map = Map.new(Vector2(-287, -80), 9, 17, Vector2(29, 26))

var goal

func _ready():
	for i in range(texture.get_width()/300):
		var atlas_texture := AtlasTexture.new()
		atlas_texture.set_atlas(texture)
		atlas_texture.set_region(Rect2(i*300, 0, 300, 300))
		tiles.append(atlas_texture)
	
	font = FontFile.new()
	font.font_data = load("res://fonts/Next Sunday.ttf")
	
	map.generateMap(Vector2(574*2, 324*2))
	map.setWalls()
	queue_redraw()
	
	var load = load("res://objects/scene4/player.tscn")
	player = load.instantiate()
	var newPosition = Vector2(randi_range(0, 16), randi_range(0, 8))
	while map.nodes[newPosition.x][newPosition.y].wall:
		newPosition = Vector2(randi_range(0, 16), randi_range(0, 8))
	player.posIndex = newPosition
	get_node("Player").add_child(player)
	
	instantiateItems()
	
func _process(_delta):
	if !enemyRandom and get_parent().difficultyFase4 >= 2:
		enemyRandom = spawnEnemy("res://objects/scene4/enemyRandom.tscn")
	elif !enemyFollow and get_parent().difficultyFase4 >= 4:
		enemyFollow = spawnEnemy("res://objects/scene4/enemyFollow.tscn")
	elif !enemyGoal and get_parent().difficultyFase4 >= 5:
		enemyGoal = spawnEnemy("res://objects/scene4/enemyGoal.tscn")
		
	queue_redraw()
	pass
	
func changePlayerPos(value):
	playerPos = value
	if enemyFollow:
		enemyFollow.pf.resetAll()
		enemyFollow.pf.setStartGoal(enemyFollow.posIndex, playerPos)
		enemyFollow.pf.setAllCosts()
		enemyFollow.pf.search()

func updatePos(obj, i, j):
	obj.position = Vector2(map.nodes[i][j].position) + Vector2(map.nodes[i][j].size/2, map.nodes[i][j].size/2)

func instantiateItems():
	for i in get_node("Items").get_children():
		i.queue_free()
	for i in map.nodes:
		for j in i:
			if j.item != null:
				j.item = null
	
	var instances = []
	
	for i in range(floor(get_parent().difficultyFase4) + 1):
		var load = load("res://objects/scene4/item.tscn")
		var item = load.instantiate()
		
		var newPosition = Vector2(randi_range(0, 16), randi_range(0, 8))
		while map.nodes[newPosition.x][newPosition.y].wall or instances.find(newPosition) != -1:
			newPosition = Vector2(randi_range(0, 16), randi_range(0, 8))
		instances.append(newPosition)
		updatePos(item, newPosition.x, newPosition.y)
		
		if i == 0:
			item.itemName = item.item[randi_range(0, 3)]
			goal = item.itemName
			goal_sprite.texture = load(item.sprite[item.item.find(item.itemName)])
			get_node("Player/Player").goal = goal
		else:
			item.itemName = item.item[randi_range(0, 3)]
			while item.itemName == goal:
				item.itemName = item.item[randi_range(0, 3)]
		map.nodes[newPosition.x][newPosition.y].item = item
		get_node("Items").add_child(item)
			
	for i in get_node("Enemies").get_children():
		if i.get_groups()[0] != "follow":
			i.goToNextItem()
	
	get_parent().difficultyFase4 += 0.2

func spawnEnemy(enemyPath):
	var load = load(enemyPath)
	var enemy = load.instantiate()
	var newPosition = Vector2(randi_range(0, 16), randi_range(0, 8))
	while map.nodes[newPosition.x][newPosition.y].wall:
		newPosition = Vector2(randi_range(0, 16), randi_range(0, 8))
	enemy.posIndex = newPosition
	get_node("Enemies").add_child(enemy)
	return enemy
	
func _draw():
	for i in map.nodes:
		for j in i:
			if j.wall:
				draw_texture_rect(tiles[1], Rect2(j.position.x, j.position.y, 30, 30), true)
				draw_texture(texture, Vector2(j.position), Color(0,0,0,0))
				#draw_rect(Rect2(Vector2(j.position),Vector2(j.size, j.size)),Color(0, 0, 0, 1))
			else:
				draw_texture_rect(tiles[0], Rect2(j.position.x, j.position.y, 30, 30), true)
				#draw_rect(Rect2(Vector2(j.position),Vector2(j.size, j.size)),Color(1, 1, 1, 1))
				pass
	'''
	for i in enemyRandom.pf.nodes:
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
	for i in enemyRandom.pf.nodes:
		for j in i:
			draw_string(font, Vector2(j.position.x, j.position.y+10), str("F: ", str(j.costF)), 0, -1, 10, Color(0, 0, 0, 1.0))
			draw_string(font, Vector2(j.position.x, j.position.y+20), str("G: ", str(j.costG)), 0, -1, 10, Color(0, 0, 0, 1.0))
	'''
