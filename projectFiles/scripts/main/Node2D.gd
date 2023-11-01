extends Node2D

var telaMenu = preload("res://scenes/menu.tscn")
var telaFase1 = preload("res://scenes/Scene1.tscn")
var telaFase1Ajuda = preload("res://scenes/Scene1Help.tscn")

var instance

var done = false

var mistakes = 0
var vecM = []
var time = -1

var tick = 7 * 3

var dificulty = 0

var fullscreen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	instance = telaMenu.instantiate()
	add_child(instance)

func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
		if fullscreen == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			fullscreen = true
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			fullscreen = false
	
	if time > 0:
		time -= delta
	
	verifyTime()

func switchScenes(scene):
	if scene == 0:
		resetVec()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		for _i in self.get_children():
			_i.queue_free()
		instance = telaMenu.instantiate()
		#get_node("@Node2D@2").name = "Menu"
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
	vecM.append(mistakes)
	mistakes = 0
	print(vecM)
	print("________________")
	print(dificulty)

func regulateDificulty():
	if vecM[0] == 0 and vecM[1] == 0 and vecM[2] == 0:
		if dificulty != 5:
			dificulty += 1
	elif vecM[0]+vecM[1]+vecM[2] > dificulty:
		if dificulty != 0:
			dificulty -= 1
	time = tick
	vecM.clear()

func resetVec():
	vecM.clear()
	mistakes = 0
	time = -1
