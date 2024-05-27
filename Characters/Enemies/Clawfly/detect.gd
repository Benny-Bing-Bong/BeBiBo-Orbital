extends ShapeCast2D


func _process(delta: float) -> void:
	if is_colliding():
		var collision_point: Vector2 = get_collision_point(0)
