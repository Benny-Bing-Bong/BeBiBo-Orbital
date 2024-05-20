extends Damageable

func _die() -> void:
	get_parent().queue_free()
