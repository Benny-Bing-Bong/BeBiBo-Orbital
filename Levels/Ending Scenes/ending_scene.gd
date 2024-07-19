extends CanvasLayer

const SCREEN_BALLOON = preload("res://Levels/Ending Scenes/screen_balloon.tscn")
const GOOD_END_TEXT = preload(
	"res://Levels/Ending Scenes/Ending Text/good_end_text.dialogue")
const BAD_END_TEXT = preload(
	"res://Levels/Ending Scenes/Ending Text/bad_end_text.dialogue")

@onready var base_texture_rect: TextureRect = $BaseTextureRect
@onready var good_texture_rect: TextureRect = $GoodTextureRect
@onready var bad_texture_rect: TextureRect = $BadTextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var ending_type: String = "Good"

func _ready() -> void:
	# If there is even one SQ not completed, change ending_type_to Bad
	for key: String in DSM.sidequest_completed_dict:
		if not DSM.sidequest_completed_dict[key]:
			ending_type = "Bad"
	
	if ending_type == "Good":
		animation_player.play("Good End")
	if ending_type == "Bad":
		animation_player.play("Bad End")

# From here on are the cutscene activation functions called by AnimationPlayer
func fade_base_to_black() -> void:
	# Change back to original color first
	base_texture_rect.modulate = Color(1,1,1)
	
	# Play pulsing sfx
	CutsceneSFX.pulse()
	
	var _tween: Tween = get_tree().create_tween()
	# Fade to black in 2 seconds
	_tween.tween_property(base_texture_rect, "modulate", Color(0,0,0), 2)

func show_good_end() -> void:
	good_texture_rect.visible = true
	base_texture_rect.visible = false
	
	# Play SFX and Music
	GameMusic.play_good_end_music()
	CutsceneSFX.good_end()
	
	# Allow player to take in what happened
	await get_tree().create_timer(3).timeout
	
	var _tween: Tween = get_tree().create_tween()
	_tween.finished.connect(start_good_end_dialogue)
	# Fade to black in 2 seconds
	_tween.tween_property(good_texture_rect, "modulate", Color(0,0,0), 2)

func start_good_end_dialogue() -> void:
	var dia_balloon: Node = SCREEN_BALLOON.instantiate()
	get_tree().current_scene.add_child(dia_balloon)
	dia_balloon.start(GOOD_END_TEXT, "start")

func show_bad_end() -> void:
	bad_texture_rect.visible = true
	base_texture_rect.visible = false
	
	# Play SFX and Music
	GameMusic.play_bad_end_music()
	CutsceneSFX.bad_end()
	
	# Allow player to take in what happened
	await get_tree().create_timer(3).timeout
	
	var _tween: Tween = get_tree().create_tween()
	_tween.finished.connect(start_bad_end_dialogue)
	# Fade to black in 2 seconds
	_tween.tween_property(bad_texture_rect, "modulate", Color(0,0,0), 2)

func start_bad_end_dialogue() -> void:
	var dia_balloon: Node = SCREEN_BALLOON.instantiate()
	get_tree().current_scene.add_child(dia_balloon)
	dia_balloon.start(BAD_END_TEXT, "start")
