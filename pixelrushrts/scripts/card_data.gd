extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getAllPossibleCards(): 
	var returnData = []
	var cardDirectory = "res://images/cards"
	var dir = DirAccess.open(cardDirectory)
	
	if dir == null:
		print("unable to find cardDirectory")
		return []
	
	var fileList = dir.get_files()
	
	for fileName in fileList: 
		var cardType = ""
		var cardColor = ""
		var cardPath = ""
		var cardName = ""
		if fileName.ends_with(".png"): 
			cardPath = cardDirectory + "/" + fileName
			var cardSplit = fileName.split("_")
			cardType = cardSplit[0]
			match cardSplit[0]:
				"hero","item","magic":
					cardType = cardSplit[0]
					cardColor = ""
					cardName = cardSplit[1].replace(".png", "")
				"slime","building","ruin": 
					cardType = cardSplit[0]
					cardColor = cardSplit[1]
					cardName = cardSplit[2].replace(".png", "")
			returnData.push_back({"cardType" = cardType, "cardColor" = cardColor, "cardPath" = cardPath, "cardName" = cardName})
			
	return returnData
