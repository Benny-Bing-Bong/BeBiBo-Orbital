extends State

@export var atk2_anim_name: String

@onready var dbl_atk_timer: Timer = $DblAtkTimer
@onready var timer: Timer = $Timer

func enter() -> void:
	super()
	timer.start();

func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("attack"):
		dbl_atk_timer.start()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == first_anim_name:
		if dbl_atk_timer.is_stopped():
			go_back_move()
		else:
			playback.travel(atk2_anim_name)
	if anim_name == atk2_anim_name:
		go_back_move()

func _on_timer_timeout() -> void:
	transitioned.emit(self, "ground")

func  go_back_move() -> void:
	transitioned.emit(self, "ground")
