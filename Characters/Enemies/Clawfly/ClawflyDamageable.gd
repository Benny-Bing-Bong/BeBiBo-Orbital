extends Damageable

@onready var timer: Timer = $Timer

func _die() -> void:
	super()
	for child in get_parent().get_children():
		if child is EnemyStateMachine:
			child.emit_signal("interrupt_state", "dead")
