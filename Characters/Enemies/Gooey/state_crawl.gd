extends State

var speed: float = 200.0
var direction : Vector2 = Vector2.LEFT

func state_physics_process(delta: float) -> void:
	character.velocity.x = direction.x * speed * delta
	
	character.move_and_slide()
