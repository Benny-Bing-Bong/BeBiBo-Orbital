extends State

@export var shockwave: PackedScene
@export var speed: float = 20.0

var direction: Vector2

@onready var timer: Timer = $Timer # 2x of animation duration, so walk twice

func enter() -> void:
	super()
	direction = Vector2.RIGHT if anim_sprite.flip_h else Vector2.LEFT
	timer.start()

func exit() -> void:
	pass

func state_physics_process(_delta: float) -> void:
	character.velocity.x = direction.x * speed
	
	character.move_and_slide()

func _on_timer_timeout() -> void:
	transitioned.emit(self, "idle")
