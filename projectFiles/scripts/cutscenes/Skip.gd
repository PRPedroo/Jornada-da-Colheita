extends Node2D

static var scene
@onready var vecScreen = []
var indexScreen = 1

func _ready():
	scene = get_parent().cutscene
	if scene >= 4:
		scene = 0
	
	for i in get_node("Camera2D").get_children():
		vecScreen.append(i)

func _on_button_button_up():
	if indexScreen < vecScreen.size():
		changeScreen()
	else:
		scene += 1
		get_parent().cutscene = scene
		get_parent().switchScenes(scene)

func changeScreen():
	vecScreen[indexScreen-1].visible = false
	vecScreen[indexScreen].visible = true
	indexScreen += 1


