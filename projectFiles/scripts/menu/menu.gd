extends Node2D

func _on_button_pressed():
	get_parent().switchScenes(1)
	#get_tree().change_scene_to_file("res://scenes/Scene1.tscn")
	
