extends Node

enum type {drink, fruit, ingredient, meal}
enum color {purple, yellow, red, white, brown}
enum shape {round, alongated, liquid, rectangular}

var item = ["apple", "banana", "grapes", "bread", "milk", "egg"]
var sprite = ["res://sprites/scene2/appleSpriteSheet.png", "res://sprites/scene2/bananaSpriteSheet.png", "res://sprites/scene2/grapesSpriteSheet.png", "res://sprites/scene4/paoSpriteSheet.png", "res://sprites/scene4/leiteSpriteSheet.png", "res://sprites/scene4/ovoSpriteSheet.png"]
var itemName

# Called when the node enters the scene tree for the first time.
func _ready():
	get_child(0).texture = load(sprite[item.find(itemName)])

func remove():
	queue_free()
	
func getTraits():
	if itemName == "apple":
		return normalizeVec([type.fruit, color.red, shape.round])
	elif itemName == "banana":
		return normalizeVec([type.fruit, color.yellow, shape.alongated])
	elif itemName == "grapes":
		return normalizeVec([type.fruit, color.purple, shape.round])
	elif itemName == "bread":
		return normalizeVec([type.meal, color.brown, shape.rectangular])
	elif itemName == "milk":
		return normalizeVec([type.drink, color.white, shape.liquid])
	elif itemName == "egg":
		return normalizeVec([type.ingredient, color.white, shape.round])

func normalizeVec(vec):
	return [float(vec[0])/(type.size()-1), float(vec[1])/(color.size()-1), float(vec[2])/(shape.size()-1)]
