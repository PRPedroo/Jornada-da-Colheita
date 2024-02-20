extends Area2D

static var left = 0
static var right = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.get_parent().get_groups()[0] == "road":
		if get_groups()[0] == "left":
			left = 1
		if get_groups()[0] == "right":
			right = 1
		
		get_parent().run_neural_network()


func _on_area_exited(area):
	if area.get_parent().get_groups()[0] == "road":
		if get_groups()[0] == "left":
			left = 0
		if get_groups()[0] == "right":
			right = 0
		
		get_parent().run_neural_network()
