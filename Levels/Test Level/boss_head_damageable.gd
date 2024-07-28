extends Damageable

signal final_stage
signal actual_death

var final_stage_triggered: bool = false

func take_damage(value: int) -> void:
	super(value)
	
	print(health)
	
	if not final_stage_triggered and health <= 9:
		emit_signal("final_stage")
		final_stage_triggered = true

func _die() -> void:
	super()
	for child in get_parent().get_children():
		if child is EnemyStateMachine:
			child.emit_signal("interrupt_state", "dead")
	emit_signal("actual_death")
