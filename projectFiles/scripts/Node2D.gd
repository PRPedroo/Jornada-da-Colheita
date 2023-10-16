extends Node2D

var telaMenu = preload("res://scenes/menu.tscn")
var telaFase1 = preload("res://scenes/Scene1.tscn")

var instance

# Called when the node enters the scene tree for the first time.
func _ready():
	instance = telaMenu.instantiate()
	add_child(instance)
	
func switchScenes(scene):
	if scene == 0:
		self.get_node("Fase1").queue_free()
		instance = telaMenu.instanciate()
		get_node("@Node2D@2").name = "Menu"
		self.add_child(instance)
	if scene == 1:
		self.get_node("Menu").queue_free()
		instance = telaFase1.instanciate()
		get_node("@Node2D@2").name = "Fase1"
		self.add_child(instance)
	
