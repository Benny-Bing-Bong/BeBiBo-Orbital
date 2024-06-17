extends State

@export var double_jump_velocity: float = -350.0

@onready var buffer_timer: Timer = $Timer
@onready var wallhang_timer: Timer = $WallhangTimer

func enter() -> void:
	super()
	PlayerManager.double_jumped = true
	character.velocity.y = double_jump_velocity
	buffer_timer.start()
	wallhang_timer.start()

func state_process(_delta: float) -> void:
	if character.is_on_floor() and buffer_timer.is_stopped():
		land()
	
	if character.is_on_wall() and wallhang_timer.is_stopped():
		wallhang()

func state_physics_process(_delta: float) -> void:
	if character.velocity.y >= 0:
		get_parent().emit_signal("interrupted_state", "falling")

func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("dash"):
		dash()

func land() -> void:
	transitioned.emit(self, "landing")

func wallhang() -> void:
	if UnlockManager.able_to("wallhang"):
		transitioned.emit(self, "wallhang")

func dash() -> void:
	if UnlockManager.able_to("dash") and StaminaManager.has_charge():
		StaminaManager.use_charge()
		transitioned.emit(self, "dash")
