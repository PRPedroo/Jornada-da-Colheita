extends Node2D

@onready var screen = $screen
@onready var goal_sprite = $Camera2D/HUD/Sprite2D

@onready var pausehud = $Camera2D/Pause
@onready var finalhud = $Camera2D/Final
@onready var finalContinuehud = $Camera2D/FinalContinue
@onready var hud = $Camera2D/HUD

@onready var points_label = $Camera2D/HUD/pointsLabel
@onready var timer_label = $Camera2D/HUD/timer
@onready var dif_label = $Camera2D/HUD/dif

var np = NumpyHandmade.new()

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

var pause = false
var end = false

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
	timer_label.text = str("tempo: ", ceil(player.timerDif))
	dif_label.text = str("dif: ", ceil(get_parent().difficultyFase4))
	
	checkDificulty()
		
	if Input.is_action_just_pressed("esc"):
		pause = !pause
		pausehud.visible = !pausehud.visible
	
		
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
	points_label.text = str(player.points)
	for i in range(floor(get_parent().difficultyFase4) + 1):
		var load = load("res://objects/scene4/item.tscn")
		var item = load.instantiate()
		
		var newPosition = Vector2(randi_range(0, 16), randi_range(0, 8))
		while map.nodes[newPosition.x][newPosition.y].wall or instances.find(newPosition) != -1:
			newPosition = Vector2(randi_range(0, 16), randi_range(0, 8))
		instances.append(newPosition)
		updatePos(item, newPosition.x, newPosition.y)
		
		if i == 0:
			item.itemName = item.item[randi_range(0, 5)]
			goal = item.itemName
			goal_sprite.texture = load(item.sprite[item.item.find(item.itemName)])
			get_node("Player/Player").goal = goal
			player.timerDif = (float(np.abs(newPosition.x + newPosition.y - player.posIndex.x - player.posIndex.y))/24) * 16
			if player.timerDif < 4:
				player.timerDif = 4
		else:
			item.itemName = item.item[randi_range(0, 5)]
			while item.itemName == goal:
				item.itemName = item.item[randi_range(0, 5)]
		map.nodes[newPosition.x][newPosition.y].item = item
		get_node("Items").add_child(item)
			
	for i in get_node("Enemies").get_children():
		i.stun = 2
		if i.get_groups()[0] != "follow":
			i.goToNextItem()

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

func endGame():
	pause = true
	hud.visible = false
	if get_parent().storyMode == true:
		finalContinuehud.visible = true
	else:
		finalhud.visible = true

func checkDificulty():
	if !enemyRandom and get_parent().difficultyFase4 >= 2:
		enemyRandom = spawnEnemy("res://objects/scene4/enemyRandom.tscn")
	elif enemyRandom and get_parent().difficultyFase4 < 2:
		enemyRandom.queue_free()
		enemyRandom = null
	if !enemyFollow and get_parent().difficultyFase4 >= 3:
		enemyFollow = spawnEnemy("res://objects/scene4/enemyFollow.tscn")
	elif enemyFollow and get_parent().difficultyFase4 < 3:
		enemyFollow.queue_free()
		enemyFollow = null
	if !enemyGoal and get_parent().difficultyFase4 >= 4:
		enemyGoal = spawnEnemy("res://objects/scene4/enemyGoal.tscn")
	elif enemyGoal and get_parent().difficultyFase4 < 4:
		enemyGoal.queue_free()
		enemyGoal = null

func _on_menu_button_up():
	get_parent().switchScenes(0) # BOTÃO PARA VOLTAR AO MENU

func _on_play_again_button_up():
	get_parent().switchScenes(4) # BOTÃO PARA VOLTAR PARA REJOGAR A FASE

func _on_continue_story_button_button_up():
	get_parent().switchScenes(5)

func _on_resume_button_up():
	pause = false # BOTÃO PARA DESPAUSAR
	pausehud.visible = !pausehud.visible
