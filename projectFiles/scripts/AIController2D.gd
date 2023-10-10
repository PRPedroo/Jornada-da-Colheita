extends AIController2D

var move = 0

@onready var character = $".."
@onready var target = $"../../Target"

func get_obs() -> Dictionary:
	var obs: = [
		character.position.x,
		target.position.x,
		character.time
	]
	return {"obs" : obs}

func get_reward() -> float:
	return reward

func get_action_space() -> Dictionary:
	return {
		"move" : {
			"size": 1,
			"action_type": "continuous" #discrete continuous
		}
	}
	
func set_action(action) -> void:
	move = action["move"][0]
	#print(move)
	#if(count < sizeMove):
	#	move.append(action["move"])
	#	count = count + 1
	#else:
	#	character.calcVec()
	#	move.clear()
	
# -----------------------------------------------------------------------------#

#-- Methods that can be overridden if needed --#

#func get_obs_space() -> Dictionary:
# May need overriding if the obs space is complex
#	var obs = get_obs()
#	return {
#		"obs": {
#			"size": [len(obs["obs"])],
#			"space": "box"
#		},
#	}
