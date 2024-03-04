extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y <= 0:
		position.y += 2
	else:
		get_parent().get_parent().endGame()
