extends Damageable

func _die() -> void:
	for child in get_parent().get_children():
		if child is PlayerStateMachine:
			child.emit_signal("interrupted_state", "death")
	print("Player has died. Press P to restart scene")
