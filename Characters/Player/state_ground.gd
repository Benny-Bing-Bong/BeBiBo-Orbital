extends State

func state_input(_input: InputEvent) -> void:
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

func jump() -> void:
	if UnlockManager.able_to("jump"):
		transitioned.emit(self, "air")

func attack() -> void:
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
