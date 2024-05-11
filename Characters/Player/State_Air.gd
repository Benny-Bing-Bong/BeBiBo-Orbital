extends State

@export var jump_velocity: float = -400.0
@export var double_jump_velocity: float = -300.0
@export var jump_double_anim_name: String

@onready var buffer_timer: Timer = $Timer # Prevent immediate transition to land

var has_doubled: bool = false

func enter() -> void:
	super()
	character.velocity.y = jump_velocity
	buffer_timer.start()

func exit() -> void:
	has_doubled = false

func state_process(delta: float) -> void:
	if character.is_on_floor() && buffer_timer.is_stopped():
		land()

func state_input(input: InputEvent) -> void:
	if input.is_action_pressed("up") && !has_doubled:
		has_doubled = true
		double_jump()

func land() -> void:
	transitioned.emit(self, "landing")

func double_jump() -> void:
	character.velocity.y = double_jump_velocity
	playback.travel(jump_double_anim_name)
