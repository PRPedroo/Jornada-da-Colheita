extends Node2D

@onready var pausehud = $Camera2D/Pause

@onready var player = $Player

var timer = 51

var pause = false

func _process(delta):
	if get_parent().fullscreen and !pause:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_just_pressed("esc"):
		pause = !pause
		pausehud.visible = !pausehud.visible
		
func _on_menu_pressed():
	get_parent().switchScenes(0) # BOTÃO PARA VOLTAR AO MENU (TELA PAUSE)


func _on_resume_pressed():
	pause = false # BOTÃO PARA VOLTAR PARA REJOGAR A FASE (TELA PAUSE)
	pausehud.visible = !pausehud.visible
