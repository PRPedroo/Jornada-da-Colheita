extends Node

enum type {drink, fruit, ingredient}
enum color {purple, yellow, red, white}

var item = ["apple", "banana", "grapes", "bread"]
var sprite = ["res://sprites/scene2/appleSpriteSheet.png", "res://sprites/scene2/bananaSpriteSheet.png", "res://sprites/scene2/grapesSpriteSheet.png", "res://sprites/scene4/paoSpriteSheet.png"]
var itemName

var itemType
var itemColor
# Called when the node enters the scene tree for the first time.
func _ready():
	get_child(0).texture = load(sprite[item.find(itemName)])

func remove():
	queue_free()
