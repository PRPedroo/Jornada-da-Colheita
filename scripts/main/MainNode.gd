extends Node2D

var arrow = load("res://sprites/cursorDefault.png")
var arrowClick = load("res://sprites/cursorClick.png")

var telaMenu = preload("res://scenes/menu.tscn")

var telaFase1 = preload("res://scenes/Scene1.tscn")
var telaFase1Ajuda = preload("res://scenes/Scene1Help.tscn")

var telaFase2 = preload("res://scenes/Scene2.tscn")

var instance

var done = false

var mistakes = 0
var vecM = []
var time = -1
var pauseTime = false

var tick = 7 * 3

var difficultyFase1 = 2
var difficultyFase2 = 2

var fullscreen = false

# Called when the node enters the scene tree for the first time.
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
	if scene == 0:
		resetVec()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		for _i in self.get_children():
			_i.queue_free()
		instance = telaMenu.instantiate()
		self.add_child(instance)

	if scene == 1:
		resetVec()
		time = tick
		for _i in self.get_children():
			_i.queue_free()
		instance = telaFase1.instantiate()
		self.add_child(instance)
	if scene == 11:
		for _i in self.get_children():
			_i.queue_free()
		instance = telaFase1Ajuda.instantiate()
		self.add_child(instance)

	if scene == 2:
		resetVec()
		#time = tick
		for _i in self.get_children():
			_i.queue_free()
		instance = telaFase2.instantiate()
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
	if mistakes >= difficultyFase2:
		if difficultyFase1 != 0:
			difficultyFase2 -= 1
	elif mistakes == 0:
		if difficultyFase1 != 5:
			difficultyFase2 += 1
	mistakes = 0

func addMistakes():
	mistakes = mistakes + 1
