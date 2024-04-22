extends Node2D

@onready var animation_player = $Player/AnimationPlayer

@onready var hud = $Camera2D/HUD
@onready var final = $Camera2D/Final
@onready var finalContinue = $Camera2D/FinalContinue
@onready var pausehud = $Camera2D/Pause

@onready var enemy_slider = $Camera2D/HUD/VSlider
@onready var player_slider = $Camera2D/HUD/VSlider2

@onready var player = $Player
@onready var enemy = $Enemy

@onready var loading_screen = $loadingScreen

@onready var market = preload("res://objects/scene3/market.tscn")

var pause = false
var end = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("idle")
	Input.set_custom_mouse_cursor(get_parent().arrow)
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
	
	if !pause and !end:
		enemy_slider.value += 1 + remap(get_parent().difficultyFase3, 0, 5, +0.3, -0.3)
		player_slider.value += 1 + remap(player.speed, 50, 150, +0.5, -0.5)

	if enemy_slider.value == 2000 or player_slider.value == 2000:
		
		hud.visible = false
		var instance = market.instantiate()
		end = true
		instance.position.y = -350
		
		if player_slider.value == 2000:
			#instance.position.x = 145 ??
			player.velocity.x = 0
			pass
		else:
			enemy.velocity.x = 0
			instance.get_child(0).frame += 1
			instance.get_child(0).position.x *= -1
		
		get_child(2).add_child(instance)
		enemy_slider.value = 0
		player_slider.value = 0

func endGame():
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


func _on_resume_button_up():
	pass # Replace with function body.
