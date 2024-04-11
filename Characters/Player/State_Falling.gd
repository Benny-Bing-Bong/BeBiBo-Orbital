extends State

@export var fall_anim_name: String

func enter() -> void:
	playback.travel(fall_anim_name)

func state_process(delta: float) -> void:
	if character.is_on_floor():
		transitioned.emit(self, "ground")

func state_input(input: InputEvent) -> void:
	if input.is_action_pressed("up"):
		jump()

func jump() -> void:
	transitioned.emit(self, "air")
