extends Node2D
class_name Card

var cardSprite = ""
var cardName = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("card spawned")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# called after instantiation to set up class member values
func construct(cardSpritePath, cardNameText): 
	cardSprite = cardSpritePath
	cardName = cardNameText
	
