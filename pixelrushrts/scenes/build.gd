extends Node2D

@onready var deckArea = $DeckArea
@onready var scrollContainer = $CardScroll
@onready var vbox = $CardScroll/DeckChoiceVbox
var allCards

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	allCards = CardData.getAllPossibleCards()
	deckArea.mouse_filter = Control.MOUSE_FILTER_PASS
	#handle drop events
	deckArea.set_process_unhandled_input(true)
	populateDeckChoiceArea()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func populateDeckChoiceArea(): 
	buildDeckChoiceArea()
	populateCards()
	
func populateCards(): 
	print("populating cards")
	for card in allCards: 
		var cardType = card["cardType"]
		print(cardType)
	
func buildDeckChoiceArea():
	print("building deck choice containers")
	var slimeHorizontalScroll = ScrollContainer.new()
	var slimeHorizontalScrollBar = HScrollBar.new()
	slimeHorizontalScroll.add_child(slimeHorizontalScrollBar)
	
	var resourceHorizontalScroll = ScrollContainer.new()
	var resourceHorizontalScrollBar = HScrollBar.new()
	resourceHorizontalScroll.add_child(resourceHorizontalScrollBar)
	
	var itemHorizontalScroll = ScrollContainer.new()
	var itemHorizontalScrollBar = HScrollBar.new()
	itemHorizontalScroll.add_child(itemHorizontalScrollBar)
	
	var magicHorizontalScroll = ScrollContainer.new()
	var magicHorizontalScrollBar = HScrollBar.new()
	magicHorizontalScroll.add_child(magicHorizontalScrollBar)
	
	var buildingHorizontalScroll = ScrollContainer.new()
	var buildingHorizontalScrollBar = HScrollBar.new()
	buildingHorizontalScroll.add_child(buildingHorizontalScrollBar)
	
	var ruinHorizontalScroll = ScrollContainer.new()
	var ruinHorizontalScrollBar = HScrollBar.new()
	ruinHorizontalScroll.add_child(ruinHorizontalScrollBar)
	
	var heroHorizontalScroll = ScrollContainer.new()
	var heroHorizontalScrollBar = HScrollBar.new()
	heroHorizontalScroll.add_child(heroHorizontalScrollBar)
	
	vbox.add_child(slimeHorizontalScroll)
	vbox.add_child(resourceHorizontalScroll)
	vbox.add_child(itemHorizontalScroll)
	vbox.add_child(magicHorizontalScroll)
	vbox.add_child(buildingHorizontalScroll)
	vbox.add_child(ruinHorizontalScroll)
	vbox.add_child(heroHorizontalScroll)
	
