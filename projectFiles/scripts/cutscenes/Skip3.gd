extends Node2D

@onready var vecScreen = [$Camera2D/first]
var indexScreen = 1

func _on_button_button_up():
	if indexScreen < vecScreen.size():
		changeScreen()
	else:
		get_parent().switchScenes(3)

func changeScreen():
	vecScreen[indexScreen-1].visible = false
	vecScreen[indexScreen].visible = true
	indexScreen += 1


