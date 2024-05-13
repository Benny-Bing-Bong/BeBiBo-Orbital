extends State

var speed: float = 200.0

func enter() -> void:
	pass

func exit() -> void:
	pass

func state_input(input: InputEvent) -> void:
	pass

func state_process(delta: float) -> void:
	pass

func state_physics_process(delta: float) -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, speed * delta)
	
	anim_sprite.play("idle")
	character.move_and_slide()

func crawl() -> void:
	transitioned.emit(self, "crawl")


func _on_timer_timeout() -> void:
	crawl() # Replace with function body.
