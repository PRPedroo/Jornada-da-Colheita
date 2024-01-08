extends AIController2D

var movex = 0
var movey = 0

@onready var farmer = $".."

func get_obs() -> Dictionary:
	var obs: = [
		farmer.fruitsRemaining,
		farmer.compare,
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
		},
		"decide" : {
			"size": 1,
			"action_type": "continuous" #discrete continuous
		}
	}
	
func set_action(action) -> void:
	movex = action["move"][0]
	movey = action["move"][1]
	if action["decide"][0] >= 0:
		farmer.index = int(action["decide"][0]*farmer.size)
