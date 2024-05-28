extends State

func state_process(_delta: float) -> void:
	if character.is_on_floor():
		land()

func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("up"):
		jump()

func land() -> void:
	transitioned.emit(self, "ground")

func jump() -> void:
	if UnlockManager.able_to("jump"):
		transitioned.emit(self, "air")
