extends Node2D

static var scene
@onready var vecScreen = []
var indexScreen = 1

func _ready():
	scene = get_parent().cutscene
	if scene >= 4:
		scene = -1
	
	for i in get_node("Camera2D").get_children():
		vecScreen.append(i)
	
	if vecScreen[0].get_child(0) is AudioStreamPlayer2D:
		vecScreen[0].get_child(0).play()

func _on_button_button_up():
	if indexScreen+1 == vecScreen.size() and scene == -1:
		changeScreen()
		var credits = $Camera2D/dialog2/Node2D
		var tween = create_tween()
		tween.tween_property(credits, "position", Vector2(credits.position.x, -200), 8)
		await get_tree().create_timer(8).timeout
		scene += 1
		get_parent().cutscene = scene
		get_parent().switchScenes(scene)
	elif indexScreen < vecScreen.size():
		changeScreen()
	else:
		scene += 1
		get_parent().cutscene = scene
		get_parent().switchScenes(scene)

func changeScreen():
	vecScreen[indexScreen-1].visible = false
	vecScreen[indexScreen].visible = true
	if vecScreen[indexScreen-1].get_child(0) is AudioStreamPlayer2D and vecScreen[indexScreen].get_child(0) is AudioStreamPlayer2D:
		vecScreen[indexScreen-1].get_child(0).stop()
		vecScreen[indexScreen].get_child(0).play()
	indexScreen += 1


