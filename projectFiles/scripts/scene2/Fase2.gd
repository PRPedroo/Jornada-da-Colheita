extends Node2D

@onready var hud = $Camera2D/HUD
@onready var final = $Camera2D/Final
@onready var pausehud = $Camera2D/Pause
@onready var finalContinue = $Camera2D/FinalContinue

@onready var objective_label = $Camera2D/HUD/ObjectiveLabel
#@onready var points_label = $Camera2D/Final/PointsLabel
@onready var sprite_fruit = $Camera2D/HUD/Sprite2D

var apple = preload("res://objects/scene2/apple.tscn")
var banana = preload("res://objects/scene2/banana.tscn")
var grapes = preload("res://objects/scene2/grapes.tscn")

var vecObjects = [apple, banana, grapes]

var appleSprite = "res://sprites/scene2/appleSpriteSheet.png"
var bananaSprite = "res://sprites/scene2/bananaSpriteSheet.png"
var grapesSprite = "res://sprites/scene2/grapesSpriteSheet.png"

var vecSprites = [appleSprite, bananaSprite, grapesSprite]

@onready var apple_package = $ApplePackage
@onready var banana_package = $BananaPackage
@onready var grapes_package = $GrapesPackage

var pause = false

var grabbed = false

var numFruits = 1
var typeFruits = ["apple", "banana", "grapes"]
var fruitIndex = 0

var typeStack = ["nothing"]
var positionStack = [Vector2(-118, 162)]

func _ready():
	removeFruits()
	spawnFruits(numFruits, get_parent().difficultyFase2)

func _process(_delta):
	print(get_parent().difficultyFase2)
	if Input.is_action_just_pressed("esc"):
		pause = !pause
		pausehud.visible = !pausehud.visible
	objective_label.text = str(numFruits)
	
func changePackage():
	clearStacks()
	showPackage(fruitIndex)
	get_parent().verifyMistakes()
	if fruitIndex < 2:
		fruitIndex += 1
		sprite_fruit.texture = load(vecSprites[fruitIndex])
		
		var rng = RandomNumberGenerator.new()
		numFruits = rng.randi_range(1,4)
		
		spawnFruits(numFruits, get_parent().difficultyFase2)
		return typeFruits[fruitIndex]
	else:
		endGame()
		return null

func removeFruits():
	for _i in self.get_node("Fruits").get_children():
			_i.queue_free()

func spawnFruits(num, dif):
	removeFruits()
	for _i in range(num):
		var instance = vecObjects[fruitIndex].instantiate()
		get_node("Fruits").call_deferred("add_child", instance)
	for _i in range(dif): #TEM Q TOMAR CUIDADO NAO SEI OQ ACONTECE QUANDO DA 0
		var rand = RandomNumberGenerator.new().randi_range(0, 2)
		while (rand == fruitIndex):
			rand = RandomNumberGenerator.new().randi_range(0, 2)
		var instance = vecObjects[rand].instantiate()
		get_node("Fruits").call_deferred("add_child", instance)
		
func endGame():
	numFruits = -1
	pause = true
	hud.visible = false
	if get_parent().storyMode == true:
		finalContinue.visible = true
	else:
		final.visible = true

func showPackage(index):
	if index == 0:
		apple_package.visible = true
	elif index == 1:
		banana_package.visible = true
	else:
		grapes_package.visible = true

func addFruitStack(type, position):
	typeStack.append(type)
	positionStack.append(position)
	get_node("Farmer").refreshFruit()
	
	#print(typeStack)

func removeFruitStack():
	typeStack.pop_back()
	positionStack.pop_back()
	get_node("Farmer").refreshFruit()
	
	#print(typeStack)
	#print("---------")

func clearStacks():
	while(positionStack.size() > 1):
		removeFruitStack()

func _on_play_again_button_up():
	get_parent().switchScenes(2) # BOTÃO PARA JOGAR NOVAMENTE

func _on_menu_button_up():
	get_parent().switchScenes(0) # BOTÃO PARA VOLTAR AO MENU

func _on_continue_story_button_button_up():
	get_parent().switchScenes(33) # IR PARA CUTSCENE DA FASE 3 

func _on_resume_button_up():
	pause = false # BOTÃO PARA DESPAUSAR
	pausehud.visible = !pausehud.visible



