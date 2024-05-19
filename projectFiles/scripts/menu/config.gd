extends Node2D

@onready var music_slider = $Camera2D/Pause/MusicSlider
@onready var dub_slider = $Camera2D/Pause/DubSlider
@onready var sfx_slider = $Camera2D/Pause/SFXSlider

func _ready():
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	dub_slider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(3))

func _on_menu_button_up():
	get_parent().switchScenes(0)

func _on_music_slider_value_changed(value):
	setBusVolume(1, value)
	#print(db_to_linear(AudioServer.get_bus_volume_db(1)))

func _on_dub_slider_value_changed(value):
	setBusVolume(2, value)
	#print(db_to_linear(AudioServer.get_bus_volume_db(2)))

func _on_sfx_slider_value_changed(value):
	setBusVolume(3, value)
	#print(db_to_linear(AudioServer.get_bus_volume_db(3)))

func setBusVolume(busIndex, value):
	AudioServer.set_bus_volume_db(busIndex, linear_to_db(value))
	AudioServer.set_bus_mute(busIndex, value < 0.01)
