extends Node2D

var telaMenu = preload("res://scenes/menu.tscn")
var telaFase1 = preload("res://scenes/Scene1.tscn")

var instance

var mistakes # TO-DO
var time # ticks que verificam se o player está acertando

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

func switchScenes(scene):
	if scene == 0:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		for _i in self.get_children():
			_i.queue_free()
		instance = telaMenu.instantiate()
		#get_node("@Node2D@2").name = "Menu"
		self.add_child(instance)
	if scene == 1:
		for _i in self.get_children():
			_i.queue_free()
		instance = telaFase1.instantiate()
		self.add_child(instance)
	
