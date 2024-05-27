extends State

@onready var timer: Timer = $Timer

var speed: float = 8000.0
var direction: Vector2

func enter() -> void:
	super()
	timer.start()
	direction = character.velocity

func state_physics_process(delta: float) -> void:
	if character.velocity.x > 0:
		anim_sprite.flip_h = true
	else:
		anim_sprite.flip_h = false
		
	character.velocity = direction * speed * delta
	character.move_and_slide()

func idle() -> void:
	transitioned.emit(self, "idle")

func _on_timer_timeout() -> void:
	idle()
