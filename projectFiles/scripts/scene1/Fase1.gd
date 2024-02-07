extends Node2D

@onready var hud = $Camera2D/HUD
@onready var final = $Camera2D/Final
@onready var finalContinue = $Camera2D/FinalContinue
@onready var pausehud = $Camera2D/Pause

@onready var timer_label = $Camera2D/HUD/TimerLabel
@onready var points_label = $Camera2D/Final/PointsLabel

@onready var player = $Player

var timer = 60
var pause = false

func _ready():
	# TEM QUE TROCAR ESSA PARTE PARA EXPORTAR O PROJETO
	get_node("Sync").onnx_model_path = "/home/pedro/Documentos/Projeto de Extensão/Jornada-da-Colheita/projectFiles/modelfinal.onnx"
	#get_node("Sync").onnx_model_path = "modelfinal.onnx"

func _process(delta):
	checkFullscreen()
	checkPause()
	runTimer(delta)


func endGame():
	pause = true
	hud.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if get_parent().storyMode == false:
		final.visible = true
	else:
		finalContinue.visible = true
	
func _on_menu_button_up():
	get_parent().switchScenes(0) # BOTÃO PARA VOLTAR AO MENU (TELA PAUSE)

func _on_play_again_button_up():
	get_parent().switchScenes(1) # BOTÃO PARA VOLTAR PARA REJOGAR A FASE (TELA FINAL)

func _on_continue_story_button_button_up():
	get_parent().switchScenes(2) # IR PRA FASE 22 (CUTSCENE DA FASE 2)

func _on_resume_pressed():
	pause = false # BOTÃO PARA VOLTAR PARA REJOGAR A FASE (TELA PAUSE)
	pausehud.visible = !pausehud.visible


func checkFullscreen():
	if get_parent().fullscreen and !pause:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func checkPause():
	if Input.is_action_just_pressed("esc"):
		pause = !pause
		pausehud.visible = !pausehud.visible
		get_parent().pauseTime = !get_parent().pauseTime

func runTimer(delta):
	if(!pause):
		timer_label.text = str(floor(timer))
		timer -= delta
		
	if floor(timer) == 0:
		endGame()
	if floor(timer) <= 10:
		timer_label.set("theme_override_colors/font_color",Color(255, 255, 0, 255))
	if floor(timer) <= 5:
		timer_label.set("theme_override_colors/font_color",Color(255, 0, 0, 255))


