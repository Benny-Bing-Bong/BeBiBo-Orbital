extends Damageable

func take_damage(value: int) -> void:
	super(value)
	GooeySFX.hurt()
	if health > 0:
		for child in get_parent().get_children():
			if child is EnemyStateMachine:
				child.emit_signal("interrupt_state", "knockback")

func _die() -> void:
	super()
	for child in get_parent().get_children():
		if child is EnemyStateMachine:
			child.emit_signal("interrupt_state", "dead")
