extends Node2D
var _ad_view : AdView
var _rewarded_ad : RewardedAd
var _full_screen_content_callback : FullScreenContentCallback
var on_user_earned_reward_listener := OnUserEarnedRewardListener.new()

#access to load related scenes
const VERSUS_SCENE_PATH = "res://scenes/Versus.tscn"
const STORY_SCENE_PATH  = "res://scenes/Story.tscn"
const BUILD_SCENE_PATH  = "res://scenes/Build.tscn"
const DRAFT_SCENE_PATH  = "res://scenes/Draft.tscn"

@onready var play_games_sign_in_client: PlayGamesSignInClient = $PlayGamesSignInClient
@onready var snapshots_client: PlayGamesSnapshotsClient = $PlayGamesSnapshotsClient

func _enter_tree() -> void:
	print("enter tree")
	GodotPlayGameServices.initialize()

func _ready() -> void:
	print("ready")
	if not GodotPlayGameServices.android_plugin: 
		print("Plugin not found")
	else: 
		print("Plugin found")
		
	#try to sign in to google games automatically	
	play_games_sign_in_client.is_authenticated()
	$SignInButton.pressed.connect(func(): 
		play_games_sign_in_client.sign_in()
	)
	#play_games_sign_in_client.connect("user_authenticated", _on_user_authenticated)
	
	#initialize google admob
	var onInitializationCompleteListener = OnInitializationCompleteListener.new()
	onInitializationCompleteListener.on_initialization_complete = onAdInitializationComplete
	var request_configuration = RequestConfiguration.new()
	MobileAds.initialize(onInitializationCompleteListener)
	if MobileAds: 
		MobileAds.set_request_configuration(request_configuration)
		
	snapshots_client.load_game("playerData", true)
		
		
#called when user is authenticated with google games
func _on_user_authenticated(is_authenticated: bool) -> void:
	print("Hi from Godot! User is authenticated? %s" % is_authenticated)
	hideOrShowAuthenticatedButtons(is_authenticated)
	#play_games_sign_in_client.is_authenticated()

#shows or hides the google games related functionality based off auth status
func hideOrShowAuthenticatedButtons(isAuth) -> void: 
	if(isAuth): 
		$SignInButton.visibility = false
	else: 
		$SignInButton.visibility = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#called after admob init is complete, loads a banner ad
func onAdInitializationComplete(status : InitializationStatus): 
	print("banner ad initialization complete")
	_create_ad_view()

#code to load banner ad
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

#code to launch a rewarded ad, triggered manually by player
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
		

#called after user watches the manually launched rewarded ad
func on_user_earned_reward(rewarded_item : RewardedItem):
	print("on_user_earned_reward, rewarded_item: rewarded", rewarded_item.amount, rewarded_item.type)
	#once we are using an actual unit-id from admob, the rewarded_item.amount and rewarded_item.type values are set in the admob console
	#for our case, we are rewarding 25 coins to the player and must save it to the user data
	
	#TODO - reward player with coins


#buttons to change to the different scenes in the game
func _on_versus_button_pressed() -> void:
	get_tree().change_scene_to_file(VERSUS_SCENE_PATH)


func _on_story_button_pressed() -> void:
	get_tree().change_scene_to_file(STORY_SCENE_PATH)


func _on_build_button_pressed() -> void:
	get_tree().change_scene_to_file(BUILD_SCENE_PATH)


func _on_draft_button_pressed() -> void:
	get_tree().change_scene_to_file(DRAFT_SCENE_PATH)

#manual sign in with google games was pressed
func _on_sign_in_button_pressed() -> void:
	print("sign in button manually pressed")
	play_games_sign_in_client.sign_in()
