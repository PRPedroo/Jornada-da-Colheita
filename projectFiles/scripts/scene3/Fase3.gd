extends Node2D

@onready var hud = $Camera2D/HUD
@onready var final = $Camera2D/Final
@onready var finalContinue = $Camera2D/FinalContinue
@onready var pausehud = $Camera2D/Pause

@onready var enemy_slider = $Camera2D/HUD/VSlider
@onready var player_slider = $Camera2D/HUD/VSlider2

@onready var player = $Player

@onready var loading_screen = $loadingScreen

var pause = false

# Called when the node enters the scene tree for the first time.
func _ready():
	loading_screen.visible = true
	get_tree().set_pause(true)
	await get_tree().create_timer(3).timeout
	get_tree().set_pause(false) 
	loading_screen.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		pause = !pause
		pausehud.visible = !pausehud.visible
	
	if !pause:
		enemy_slider.value += 1
		player_slider.value += 1 + remap(player.speed, 50, 150, +0.5, -0.5)

	if enemy_slider.value == 2000 or player_slider.value == 2000:
		if get_parent().storyMode == false:
			final.visible = true
		else:
			finalContinue.visible = true
		pause = true

func _on_menu_button_up():
	get_parent().switchScenes(0) # BOTÃO PARA VOLTAR AO MENU

func _on_play_again_button_up():
	get_parent().switchScenes(3) # BOTÃO PARA VOLTAR PARA REJOGAR A FASE

func _on_continue_story_button_button_up():
	get_parent().switchScenes(0) # IR PRA FASE 44 (CUTSCENE DA FASE 4)

func _on_resume_pressed():
	pause = false # BOTÃO PARA DESPAUSAR
	pausehud.visible = !pausehud.visible
