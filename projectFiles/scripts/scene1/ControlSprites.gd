extends Node2D

var appleSprite = "res://sprites/scene2/appleSpriteSheet.png"
var bananaSprite = "res://sprites/scene2/bananaSpriteSheet.png"
var grapesSprite = "res://sprites/scene2/grapesSpriteSheet.png"

var vecSprites = [appleSprite, bananaSprite, grapesSprite]

var contTarget = 0
var contFruit = -2
	
func nextSprite():
	if contTarget < 2:
		contTarget += 1
	else:
		contTarget = 0
	if contFruit < 2:
		contFruit += 1
	else:
		contFruit = 0
	
