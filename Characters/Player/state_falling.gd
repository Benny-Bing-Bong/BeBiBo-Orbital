extends State

@onready var buffer_timer: Timer = $Timer # Prevent immediate transition to land
@onready var wallhang_timer: Timer = $WallhangTimer

func state_process(_delta: float) -> void:
	if character.is_on_floor():
		land()
	
	if character.is_on_wall() and wallhang_timer.is_stopped():
		wallhang()


func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("up"):
		jump()
	if _input.is_action_pressed("dash"):
		dash()

func land() -> void:
	transitioned.emit(self, "landing")

func jump() -> void:
	if UnlockManager.able_to("jump"):
		transitioned.emit(self, "air")

func wallhang() -> void:
	if UnlockManager.able_to("wallhang"):
		transitioned.emit(self, "wallhang")

func dash() -> void:
	if UnlockManager.able_to("dash") and StaminaManager.has_charge():
		StaminaManager.use_charge()
		transitioned.emit(self, "dash")
