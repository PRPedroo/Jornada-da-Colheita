extends Node2D

@onready var hud = $Camera2D/HUD
@onready var final = $Camera2D/Final
@onready var pausehud = $Camera2D/Pause

@onready var timer_label = $Camera2D/HUD/TimerLabel
@onready var points_label = $Camera2D/Final/PointsLabel

@onready var player = $Player

var timer = 51

var pause = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Sync").onnx_model_path = "/home/pedro/Documentos/Projeto de Extensão/ProjetoEX/projectFiles/modelfinal.onnx"
	#get_node("Apples").queue_free()
	pass

func _process(delta):
	if get_parent().fullscreen and !pause:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_just_pressed("esc"):
		pause = !pause
		pausehud.visible = !pausehud.visible
		# pause menu
	
	if(!pause):
		timer_label.text = str(floor(timer))
		timer -= delta
		
	if floor(timer) == 0:
		endGame()
		pass
	
	if floor(timer) <= 10:
		timer_label.set("theme_override_colors/font_color",Color(255, 255, 0, 255))
		
	if floor(timer) <= 5:
		timer_label.set("theme_override_colors/font_color",Color(255, 0, 0, 255))


func _on_button_2_pressed():
	get_parent().switchScenes(1) # BOTÃO PARA VOLTAR PARA REJOGAR A FASE (TELA FINAL)


func _on_button_pressed():
	get_parent().switchScenes(0) # BOTÃO DE VOLTAR PARA O MENU (TELA FINAL)

func endGame():
	pause = true
	hud.visible = false
	final.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_menu_pressed():
	get_parent().switchScenes(0) # BOTÃO PARA VOLTAR AO MENU (TELA PAUSE)


func _on_resume_pressed():
	pause = false # BOTÃO PARA VOLTAR PARA REJOGAR A FASE (TELA PAUSE)
	pausehud.visible = !pausehud.visible
