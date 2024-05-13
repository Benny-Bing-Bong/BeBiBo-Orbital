extends State

var speed: float = 200.0
var direction : Vector2 = Vector2.LEFT

func enter() -> void:
	pass

func exit() -> void:
	pass

func state_input(input: InputEvent) -> void:
	pass

func state_process(delta: float) -> void:
	pass

func state_physics_process(delta: float) -> void:
	character.velocity.x = direction.x * speed * delta
	
	anim_sprite.play("crawl")
	character.move_and_slide()
