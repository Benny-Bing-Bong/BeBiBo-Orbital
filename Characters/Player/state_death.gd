extends State

func enter() -> void:
	super()
	GameManager.player_died()
	# wait for death animation to play first
	await get_tree().create_timer(2).timeout
	
	ScreenManager.add_layer_to_screen("death")

func state_physics_process(_delta: float) -> void:
	character.velocity.x = 0
	character.move_and_slide()
