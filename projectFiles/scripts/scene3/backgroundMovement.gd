extends Node2D

var roads = [
	["res://objects/scene3/str_left.tscn", "res://objects/scene3/left_mid.tscn", "res://objects/scene3/left_right.tscn"],
	["res://objects/scene3/mid_left.tscn", "res://objects/scene3/str_mid.tscn", "res://objects/scene3/mid_right.tscn"],
	["res://objects/scene3/right_left.tscn", "res://objects/scene3/right_mid.tscn", "res://objects/scene3/str_right.tscn"]
]
var nextRoadDirt = [1, 1]
var nextRoadAsphalt = [1, 1]

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _process(delta):
	if get_parent().pause == false and get_parent().enemy_slider.value != 2000 and get_parent().player_slider.value != 2000:
		for i in get_children():
			i.position.y += 2
			
			if i.position.y >= 324:
				var load
				var instance
				var output = rng.randi_range(0, 2)
				
				if i.position.x > 100: # PISTA DA DIREITA
					nextRoadDirt.pop_front()
					nextRoadDirt.append(output) #TROCA OS PARAMETROS PARA SABER QUAL PISTA INSTANCIAR
					load = load(roads[nextRoadDirt[0]][nextRoadDirt[1]])
					instance = load.instantiate()
				else: # PISTA DA ESQUERDA
					nextRoadAsphalt.pop_front()
					nextRoadAsphalt.append(output) #TROCA OS PARAMETROS PARA SABER QUAL PISTA INSTANCIAR
					load = load(roads[nextRoadAsphalt[0]][nextRoadAsphalt[1]])
					instance = load.instantiate()
					instance.get_child(0).frame += 4
				instance.position.x = i.position.x # INSTANCIA PISTA NOVA FORA DA CAMERA
				instance.position.y = -324
				self.add_child(instance)
				
				i.queue_free() # EXCLUI PISTA FORA DA CAMERA
