extends State

@export var crouch_anim_name: String

@onready var col_shape: CollisionShape2D = $"../../CollisionShape2D"

func enter() -> void:
	playback.travel(crouch_anim_name)
	col_shape.shape.height = 30
	col_shape.position.y = 9

func exit() -> void:
	col_shape.shape.height = 46
	col_shape.position.y = 1

func state_input(input: InputEvent) -> void:
	if input.is_action_released("down"):
		go_back_move()

func state_process(delta: float) -> void:
	pass

func state_physics_process(delta: float) -> void:
	pass

func go_back_move() -> void:
	transitioned.emit(self, "ground")
