extends AnimatedSprite2D

@export var shockwave_speed: float = 0

func _physics_process(delta: float) -> void:
	move_local_x(shockwave_speed)

func _on_animation_finished() -> void:
	queue_free()
