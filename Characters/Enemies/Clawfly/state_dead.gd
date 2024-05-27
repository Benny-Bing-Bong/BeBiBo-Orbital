extends State

var speed: float = 200.0
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func state_physics_process(delta: float) -> void:
	anim_sprite.flip_v = true
	character.velocity.x = move_toward(character.velocity.x, 0, speed * delta)
	character.velocity.y += gravity * delta
	
	character.move_and_slide()
