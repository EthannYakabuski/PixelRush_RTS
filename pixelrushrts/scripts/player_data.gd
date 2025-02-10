extends Node

var currentData = ""
@onready var snapshots_client: PlayGamesSnapshotsClient = PlayGamesSnapshotsClient.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#set the players data in the global singleton
func setData(data): 
	currentData = data
	
#get the current players saved data from the global singleton
func getData(): 
	return currentData
