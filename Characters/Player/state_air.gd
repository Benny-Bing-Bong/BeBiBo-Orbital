extends State

@export var jump_velocity: float = -400.0
@export var double_jump_velocity: float = -300.0
@export var jump_double_anim_name: String

var has_doubled: bool = false

@onready var buffer_timer: Timer = $Timer # Prevent immediate transition to land
@onready var wallhang_timer: Timer = $WallhangTimer # Prevent immediate wallhang


func enter() -> void:
	super()
	character.velocity.y = jump_velocity
	buffer_timer.start()
	wallhang_timer.start()

func exit() -> void:
	has_doubled = false

func state_process(_delta: float) -> void:
	if character.is_on_floor() and buffer_timer.is_stopped():
		land()
	
	if character.is_on_wall() and wallhang_timer.is_stopped():
		wallhang()

func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("up") and !has_doubled:
		has_doubled = true
		double_jump()

func land() -> void:
	transitioned.emit(self, "landing")

func wallhang() -> void:
	if UnlockManager.able_to("wallhang"):
		transitioned.emit(self, "wallhang")

func double_jump() -> void:
	if UnlockManager.able_to("double_jump"):
		character.velocity.y = double_jump_velocity
		playback.travel(jump_double_anim_name)
