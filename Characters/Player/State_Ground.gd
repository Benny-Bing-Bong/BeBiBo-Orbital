extends State

func state_input(input: InputEvent) -> void:
	if input.is_action_pressed("up"):
		jump()
	if input.is_action_pressed("attack"):
		attack()
	if input.is_action_pressed("down"):
		crouch()

func state_process(delta: float) -> void: #TODO: Create falling state
	if !character.is_on_floor():
		transitioned.emit(self, "falling")

func jump() -> void:
	transitioned.emit(self, "air")

func attack() -> void:
	transitioned.emit(self, "attack")

func crouch() -> void:
	transitioned.emit(self, "crouch")
