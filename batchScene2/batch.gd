extends Node2D

var apple = preload("res://batchScene2/appleBatch.tscn")
var banana = preload("res://batchScene2/bananaBatch.tscn")
var grapes = preload("res://batchScene2/grapesBatch.tscn")

var vecObjects = [apple, banana, grapes]

var appleSprite = "res://sprites/scene2/appleSpriteSheet.png"
var bananaSprite = "res://sprites/scene2/bananaSpriteSheet.png"
var grapesSprite = "res://sprites/scene2/grapesSpriteSheet.png"

var vecSprites = [appleSprite, bananaSprite, grapesSprite]

var numFruits = 2
var typeFruits = ["apple", "banana", "grapes"]
var fruitIndex = 0

var typeStack = ["nothing"]
var positionStack = [Vector2(-184, 71)]

var rng = RandomNumberGenerator.new()
 
func _ready():
	removeFruits()
	spawnFruits(numFruits, rng.randi_range(1,3))
	# TEM QUE TROCAR ESSA PARTE PARA EXPORTAR O PROJETO
	#get_node("Sync").onnx_model_path = "/home/pedro/Documentos/Projeto de Extensão/ProjetoEX/projectFiles/modelfinal.onnx"
	#get_node("Sync").onnx_model_path = "modelfinal.onnx"
	pass
	
func changePackage():
	clearStacks()
	if fruitIndex < 2:
		fruitIndex += 1
		
		numFruits = rng.randi_range(1,4)
		
		spawnFruits(numFruits, rng.randi_range(1,3))
		return typeFruits[fruitIndex]
	else:
		fruitIndex = 0

func removeFruits():
	for _i in self.get_node("Fruits").get_children():
			_i.queue_free()

func spawnFruits(num, dif):
	removeFruits()
	for _i in range(num):
		var instance = vecObjects[fruitIndex].instantiate()
		get_node("Fruits").add_child(instance)
		instance.position.x *= -1
		addFruitStack(instance.get_groups()[0], Vector2(instance.position))
	for _i in range(dif): #TEM Q TOMAR CUIDADO NAO SEI OQ ACONTECE QUANDO DA 0
		var rand = RandomNumberGenerator.new().randi_range(0, 2)
		while (rand == fruitIndex):
			rand = RandomNumberGenerator.new().randi_range(0, 2)
		var instance = vecObjects[rand].instantiate()
		get_node("Fruits").add_child(instance)
		instance.position.x *= -1
		addFruitStack(instance.get_groups()[0], Vector2(instance.position))

func addFruitStack(type, position):
	typeStack.append(type)
	positionStack.append(position)
	get_node("Farmer").refreshFruit()

func removeFruitStack():
	typeStack.pop_back()
	positionStack.pop_back()
	get_node("Farmer").refreshFruit()

func clearStacks():
	while(positionStack.size() > 1):
		removeFruitStack()
