extends State

@export var move_anim_name: String

func enter() -> void:
	playback.travel(move_anim_name)

func state_input(input: InputEvent) -> void:
	if input.is_action_pressed("up"):
		jump()
	if input.is_action_pressed("attack"):
		attack()

func state_process(delta: float) -> void: #TODO: Create falling state
	if !character.is_on_floor():
		transitioned.emit(self, "falling")

func jump() -> void:
	transitioned.emit(self, "air")

func attack() -> void:
	transitioned.emit(self, "attack")
