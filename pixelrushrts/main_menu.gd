extends Node2D
var _ad_view : AdView

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#The initializate needs to be done only once, ideally at app launch.
	var onInitializationCompleteListener = OnInitializationCompleteListener.new()
	onInitializationCompleteListener.on_initialization_complete = onAdInitializationComplete
	var request_configuration = RequestConfiguration.new()
	#$DebugLabel.text = $DebugLabel.text + "calling init"
	MobileAds.initialize(onInitializationCompleteListener)
	#$DebugLabel.text = $DebugLabel.text + " post init"
	#"F03226F1DD8EFC77"
	#,"2077EF9A63D2B398840261C8221A0C9B"
	if MobileAds: 
		#request_configuration.test_device_ids = ["523a1b0eb5b6be122cd04bedf8035291","2077EF9A63D2B398840261C8221A0C9B"]
		MobileAds.set_request_configuration(request_configuration)
		#_create_ad_view()
		#check_initialization_status()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func onAdInitializationComplete(status : InitializationStatus): 
	print("banner ad initialization complete")
	_create_ad_view()

func _create_ad_view() -> void:
	#free memory
	if _ad_view:
		destroy_ad_view()

	var adListener = AdListener.new()
	adListener.on_ad_failed_to_load = func(load_ad_error : LoadAdError):
		pass 
	
	var unit_id = "ca-app-pub-3940256099942544/6300978111"

	_ad_view = AdView.new(unit_id, AdSize.BANNER, AdPosition.Values.BOTTOM_RIGHT)
	var ad_request = AdRequest.new()
	_ad_view.load_ad(ad_request)
	_ad_view.show()
	
func destroy_ad_view():
	if _ad_view:  
		_ad_view.destroy()
		_ad_view = null
