extends Node2D

@onready var first = $Camera2D/first
@onready var second = $Camera2D/second

var indexScreen = 0

func _on_button_button_up():
	if indexScreen < 1:
		changeScreen()
	else:
		get_parent().switchScenes(1)
	indexScreen += 1

func changeScreen():
		first.visible = false
		second.visible = true


