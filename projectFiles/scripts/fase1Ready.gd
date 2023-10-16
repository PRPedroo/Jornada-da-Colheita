extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Sync").onnx_model_path = "/home/pedro/Documentos/Projeto de Extensão/ProjetoEX/projectFiles/modelfinal.onnx"

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
