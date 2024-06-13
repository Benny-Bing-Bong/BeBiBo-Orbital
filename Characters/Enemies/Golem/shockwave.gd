extends AnimatedSprite2D

var shockwave_speed: int = 250

func _physics_process(delta: float) -> void:
	move_local_x(shockwave_speed * delta)

func _on_animation_finished() -> void:
	queue_free()
