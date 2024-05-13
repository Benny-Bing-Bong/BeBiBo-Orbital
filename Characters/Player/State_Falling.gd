extends State

func state_process(_delta: float) -> void:
	if character.is_on_floor():
		transitioned.emit(self, "ground")

func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("up"):
		jump()

func jump() -> void:
	transitioned.emit(self, "air")
