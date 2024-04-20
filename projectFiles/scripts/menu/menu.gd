extends Node2D

func _on_button_play_button_up():
	get_parent().switchScenes(11)
	
func _on_button_f_1_button_up():
	get_parent().switchScenes(1)
	#get_tree().change_scene_to_file("res://scenes/Scene1.tscn")

func _on_button_f_2_button_up():
	get_parent().switchScenes(2)

func _on_button_f_3_button_up():
	get_parent().switchScenes(3)

func _on_button_f_4_button_up():
	get_parent().switchScenes(4)
