extends State

@export var atk2_anim_name: String
@export var attack_speed: int = 1500

@onready var dbl_atk_timer: Timer = $DblAtkTimer
@onready var timer: Timer = $Timer
@onready var direction: Vector2
@onready var gravity: Gravity = $"../../Gravity"

func enter() -> void:
	super()
	timer.start();
	
	#gravity.disable()
	#character.velocity.y = 0
	
	#direction = character.get_facing_direction()
	#character.velocity.x = direction.x * attack_speed

func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("attack"):
		dbl_atk_timer.start()
		#character.velocity.x = direction.x * attack_speed

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == first_anim_name:
		if dbl_atk_timer.is_stopped():
			go_back_move()
		else:
			playback.travel(atk2_anim_name)
	if anim_name == atk2_anim_name:
		go_back_move()

func _on_timer_timeout() -> void:
	#gravity.enable()
	transitioned.emit(self, "ground")

func go_back_move() -> void:
	#gravity.enable()
	transitioned.emit(self, "ground")
