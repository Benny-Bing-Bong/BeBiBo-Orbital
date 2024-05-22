extends State

func enter() -> void:
	super()
	GameManager.player_died()

func state_physics_process(_delta: float) -> void:
	character.velocity.x = 0
	character.move_and_slide()
