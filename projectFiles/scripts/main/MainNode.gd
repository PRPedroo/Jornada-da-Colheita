extends Node2D

var arrow = load("res://sprites/cursorDefault.png")
var arrowClick = load("res://sprites/cursorClick.png")

var telaMenu = preload("res://scenes/menu.tscn")
var telaConfig = preload("res://scenes/config.tscn")

var telaFase1 = preload("res://scenes/Scene1.tscn")
var telaFase1CutScene = preload("res://scenes/CutScene1.tscn")

var telaFase2 = preload("res://scenes/Scene2.tscn")
var telaFase2CutScene = preload("res://scenes/CutScene2.tscn")

var telaFase3 = preload("res://scenes/Scene3.tscn")
var telaFase3CutScene = preload("res://scenes/CutScene3.tscn")

var telaFase4 = preload("res://scenes/Scene4.tscn")
var telaFase4CutScene = preload("res://scenes/CutScene4.tscn")

var telaCutSceneFINAL = preload("res://scenes/CutSceneFINAL.tscn")

var instance

var done = false

var mistakes = 0
var vecM = []
var time = -1
var pauseTime = false

var tick = 7 * 3

var difficultyFase1 = 2
var difficultyFase2 = 0
var difficultyFase3 = 3
var difficultyFase4 = 0

var fullscreen = false
var storyMode = false

var cutscene = 0

func _ready():
	Input.set_custom_mouse_cursor(arrow)
	instance = telaMenu.instantiate()
	add_child(instance)

func _process(delta):
	if Input.is_action_just_pressed("click"):
		Input.set_custom_mouse_cursor(arrowClick)
	elif Input.is_action_just_released("click"):
		Input.set_custom_mouse_cursor(arrow)
	
	if Input.is_action_just_pressed("fullscreen"):
		if fullscreen == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			fullscreen = true
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			fullscreen = false
	
	if time > 0 and !pauseTime:
		time -= delta
		verifyTime()

func switchScenes(scene):
	for i in self.get_children():
		if not i is AudioStreamPlayer2D:
			i.queue_free()
	
	if scene == 0: # MENU2
		cutscene = 0
		storyMode = false
		resetVec()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		instance = telaMenu.instantiate()
	
	if scene == -1: # CONFIG
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		instance = telaConfig.instantiate()

	if scene == 1: # FASE 1
		resetVec()
		time = tick
		instance = telaFase1.instantiate()
	if scene == 11: # CUTSCENE 1
		storyMode = true
		for _i in self.get_children():
			_i.queue_free()
		instance = telaFase1CutScene.instantiate()
	
	if scene == 2: # FASE 2
		resetVec()
		instance = telaFase2.instantiate()
	if scene == 22: # CUTSCENE 2
		resetVec()
		instance = telaFase2CutScene.instantiate()
	
	if scene == 3: # FASE 3
		instance = telaFase3.instantiate()
	if scene == 33: # CUTSCENE 3
		instance = telaFase3CutScene.instantiate()
	
	if scene == 4: # FASE 4
		instance = telaFase4.instantiate()
	if scene == 44: # CUTSCENE 4
		instance = telaFase4CutScene.instantiate()
	
	if scene == 5: # FASE5
		instance = telaCutSceneFINAL.instantiate()
	
	self.add_child(instance)
	
#--------------------FASE 1-------------------------

func verifyTime():
	if int(floor(time)) == 0:
		saveMistakes()
		regulateDificulty()
	elif int(floor(time)) % (tick/3) == 0 and !done:
		saveMistakes()
		done = true
	elif int(floor(time)) % (tick/3) != 0:
		done = false

func saveMistakes():
	if(vecM.size() >= 3):
		vecM.pop_front()
	vecM.append(mistakes)
	
	mistakes = 0
	print("Erros: ", vecM)
	print("________________")

func regulateDificulty():
	if vecM[0] == 0 and vecM[1] == 0 and vecM[2] == 0:
		if difficultyFase1 != 5:
			difficultyFase1 += 1
	elif vecM[0]+vecM[1]+vecM[2] > difficultyFase1:
		if difficultyFase1 != 1:
			difficultyFase1 -= 1
	time = tick
	vecM.clear()
	print("Dificuldade regulada.\nDificuldade atual: ",difficultyFase1)

func resetVec():
	vecM.clear()
	mistakes = 0
	time = -1

#--------------------FASE 2-------------------------

func verifyMistakes():
	if mistakes == 0:
		if difficultyFase2 < 5:
			difficultyFase2 += 1
	elif mistakes > 1:
		if difficultyFase2 > 0:
			difficultyFase2 -= 1
	mistakes = 0

func addMistakes():
	mistakes = mistakes + 1

#--------------------FASE 3-------------------------

func increaseDif():
	if difficultyFase3 < 5:
		difficultyFase3 += 1
	
func decreaseDif():
	if difficultyFase3 > 0:
		difficultyFase3 -= 1

#--------------------FASE 4-------------------------
