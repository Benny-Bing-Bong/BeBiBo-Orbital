extends CanvasLayer

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
	
	var _tween: Tween = get_tree().create_tween()
	# Fade to black in 2 seconds
	_tween.tween_property(base_texture_rect, "modulate", Color(0,0,0), 2)

func show_good_end() -> void:
	good_texture_rect.visible = true
	base_texture_rect.visible = false
	
	# Allow player to take in what happened
	await get_tree().create_timer(3).timeout
	
	var _tween: Tween = get_tree().create_tween()
	_tween.finished.connect(start_good_end_dialogue)
	# Fade to black in 2 seconds
	_tween.tween_property(good_texture_rect, "modulate", Color(0,0,0), 2)

func start_good_end_dialogue() -> void:
	print("Good Ending Dialogue Started")

func show_bad_end() -> void:
	bad_texture_rect.visible = true
	base_texture_rect.visible = false
	
	# Allow player to take in what happened
	await get_tree().create_timer(3).timeout
	
	var _tween: Tween = get_tree().create_tween()
	_tween.finished.connect(start_bad_end_dialogue)
	# Fade to black in 2 seconds
	_tween.tween_property(bad_texture_rect, "modulate", Color(0,0,0), 2)

func start_bad_end_dialogue() -> void:
	print("Bad Ending Dialogue Started")
