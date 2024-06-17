extends State

@export var jump_velocity: float = -400.0
@export var air_accel: float = 25

@onready var buffer_timer: Timer = $Timer # Prevent immediate transition to land
@onready var wallhang_timer: Timer = $WallhangTimer # Prevent immediate wallhang

func enter() -> void:
	super()
	PlayerManager.jumped = true
	
	character.velocity.y = jump_velocity
	character.accel = air_accel
	
	buffer_timer.start()
	wallhang_timer.start()

func exit() -> void:
	character.accel = character.max_speed

func state_process(_delta: float) -> void:
	if character.is_on_floor() and buffer_timer.is_stopped():
		land()
	
	if character.is_on_wall() and wallhang_timer.is_stopped():
		wallhang()

func state_physics_process(_delta: float) -> void:
	if character.velocity.y >= 0:
		get_parent().emit_signal("interrupted_state", "falling")

func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("up") and PlayerManager.can_double_jump():
		double_jump()
	
	if _input.is_action_pressed("dash"):
		dash()

func land() -> void:
	transitioned.emit(self, "landing")

func wallhang() -> void:
	if UnlockManager.able_to("wallhang"):
		transitioned.emit(self, "wallhang")

func double_jump() -> void:
	if UnlockManager.able_to("double_jump"):
		transitioned.emit(self, "doublejump")

func dash() -> void:
	if UnlockManager.able_to("dash") and StaminaManager.has_charge():
		StaminaManager.use_charge()
		transitioned.emit(self, "dash")
