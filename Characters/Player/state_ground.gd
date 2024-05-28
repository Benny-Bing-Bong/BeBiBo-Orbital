extends State

func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("up"):
		jump()
	if _input.is_action_pressed("attack"):
		attack()
	if _input.is_action_pressed("down"):
		crouch()

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
