extends State

@onready var timer: Timer = $Timer
@onready var atk_buffer_timer: Timer = $AtkBufferTimer

func enter() -> void:
	super()
	atk_buffer_timer.start()

func state_input(_input: InputEvent) -> void:
	if not character.can_move:
		return
		
	if _input.is_action_pressed("up"):
		jump()
	if _input.is_action_pressed("attack"):
		attack()
	if _input.is_action_pressed("down"):
		crouch()
	if _input.is_action_pressed("dash"):
		dash()
	if _input.is_action_pressed("laser"):
		laser()
	if _input.is_action_pressed("bomb"):
		bomb()

func state_process(_delta: float) -> void:
	if not character.is_on_floor():
		transitioned.emit(self, "falling")
	if character.is_on_floor():
		PlayerManager.reset_jumps()
		PlayerManager.reset_air_attacks()
		
		if character.velocity.x != 0 and timer.is_stopped():
			PlayerSFX.run()
			timer.start()

func jump() -> void:
	if UnlockManager.able_to("jump") and PlayerManager.can_jump():
		transitioned.emit(self, "jump")

func attack() -> void:
	if atk_buffer_timer.is_stopped():
		transitioned.emit(self, "attack")

func crouch() -> void:
	if UnlockManager.able_to("crouch"):
		transitioned.emit(self, "crouch")

func dash() -> void:
	if UnlockManager.able_to("dash") and StaminaManager.has_charge():
		StaminaManager.use_charge()
		transitioned.emit(self, "dash")

func laser() -> void:
	if UnlockManager.able_to("laser") and CooldownManager.skill_ready("laser"):
		CooldownManager.start_cooldown("laser")
		transitioned.emit(self, "laser")

func bomb() -> void:
	if UnlockManager.able_to("bomb") and CooldownManager.skill_ready("bomb"):
		CooldownManager.start_cooldown("bomb")
		transitioned.emit(self, "bomb")
