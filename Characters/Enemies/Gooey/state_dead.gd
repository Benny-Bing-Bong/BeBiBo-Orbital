extends State

var speed: float = 200.0

func state_physics_process(delta: float) -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, speed * delta)
	
	character.move_and_slide()
