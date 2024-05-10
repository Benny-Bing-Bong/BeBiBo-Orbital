extends State

@export var atk1_anim_name: String
@export var atk2_anim_name: String

@onready var dbl_atk_timer: Timer = $DblAtkTimer

func enter() -> void:
	playback.travel(atk1_anim_name)

func state_input(input: InputEvent) -> void:
	if input.is_action_pressed("attack"):
		dbl_atk_timer.start()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == atk1_anim_name:
		if dbl_atk_timer.is_stopped():
			transitioned.emit(self, "ground")
		else:
			playback.travel(atk2_anim_name)
	if anim_name == atk2_anim_name:
		transitioned.emit(self, "ground")
