extends Node2D
var _ad_view : AdView
var _rewarded_ad : RewardedAd
var _full_screen_content_callback : FullScreenContentCallback
var on_user_earned_reward_listener := OnUserEarnedRewardListener.new()

const VERSUS_SCENE_PATH = "res://scenes/Versus.tscn"
const STORY_SCENE_PATH  = "res://scenes/Story.tscn"
const BUILD_SCENE_PATH  = "res://scenes/Build.tscn"
const DRAFT_SCENE_PATH  = "res://scenes/Draft.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("ready")
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

	_ad_view = AdView.new(unit_id, AdSize.BANNER, AdPosition.Values.TOP)
	var ad_request = AdRequest.new()
	_ad_view.load_ad(ad_request)
	_ad_view.show()
	
func destroy_ad_view():
	if _ad_view:  
		_ad_view.destroy()
		_ad_view = null


func _on_ad_button_pressed() -> void:
	if _rewarded_ad: 
		_rewarded_ad.destroy()
		_rewarded_ad = null
		
	var unit_id = "ca-app-pub-3940256099942544/5224354917"
	
	var rewarded_ad_load_callback := RewardedAdLoadCallback.new()
	
	rewarded_ad_load_callback.on_ad_failed_to_load = func(adError: LoadAdError) -> void: 
		print(adError.message)
	
	rewarded_ad_load_callback.on_ad_loaded = func(rewarded_ad: RewardedAd) -> void: 
		print("rewarded ad loaded")
		_rewarded_ad = rewarded_ad
		_rewarded_ad.full_screen_content_callback = _full_screen_content_callback
		_rewarded_ad.show(on_user_earned_reward_listener)
		
	RewardedAdLoader.new().load(unit_id, AdRequest.new(), rewarded_ad_load_callback)
		
		
func on_user_earned_reward(rewarded_item : RewardedItem):
	print("on_user_earned_reward, rewarded_item: rewarded", rewarded_item.amount, rewarded_item.type)
	#once we are using an actual unit-id from admob, the rewarded_item.amount and rewarded_item.type values are set in the admob console
	#for our case, we are rewarding 25 coins to the player and must save it to the user data
	
	#TODO - reward player with coins


func _on_versus_button_pressed() -> void:
	get_tree().change_scene_to_file(VERSUS_SCENE_PATH)


func _on_story_button_pressed() -> void:
	get_tree().change_scene_to_file(STORY_SCENE_PATH)


func _on_build_button_pressed() -> void:
	get_tree().change_scene_to_file(BUILD_SCENE_PATH)


func _on_draft_button_pressed() -> void:
	get_tree().change_scene_to_file(DRAFT_SCENE_PATH)
