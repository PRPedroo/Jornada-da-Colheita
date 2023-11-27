extends AIController2D

var movex = 0
var movey = 0

@onready var farmer = $".."

func get_obs() -> Dictionary:
	var obs: = [
		farmer.position.x,
		farmer.position.y,
		farmer.positionTarget.x,
		farmer.positionTarget.y
	]
	return {"obs" : obs}

func get_reward() -> float:
	return reward

func get_action_space() -> Dictionary:
	return {
		"move" : {
			"size": 2,
			"action_type": "continuous" #discrete continuous
		}
	}
	
func set_action(action) -> void:
	movex = action["move"][0]
	movey = action["move"][1]
	#print(move) # DECISÃO DO AGENTE (INTERESSANTE DE MOSTRAR)
