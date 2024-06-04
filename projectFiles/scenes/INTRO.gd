extends Node2D

@onready var vecScreen = []
var indexScreen = 1
@onready var fade = $ColorRect

func _ready():
	for i in get_node("Camera2D").get_children():
		vecScreen.append(i)
	
	if vecScreen[0].get_child(0) is AudioStreamPlayer2D:
		vecScreen[0].get_child(0).play()

func _on_button_button_up():
	if indexScreen < vecScreen.size():
		changeScreen()
	else:
		var tween = create_tween()
		tween.tween_property(fade, "modulate", Color(modulate.r, modulate.g, modulate.b, 1), 1)
		await get_tree().create_timer(1.5).timeout
		get_parent().switchScenes(0)

func changeScreen():
	vecScreen[indexScreen-1].visible = false
	vecScreen[indexScreen].visible = true
	vecScreen[indexScreen-1].get_child(0).stop()
	vecScreen[indexScreen].get_child(0).play()
	indexScreen += 1


