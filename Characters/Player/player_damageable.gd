extends Damageable

func _ready() -> void:
	health = HealthManager.curr_health

func take_damage(value: int) -> void:
	super(value)
	HealthManager.set_health(health)

func _die() -> void:
	super()
	for child in get_parent().get_children():
		if child is PlayerStateMachine:
			child.emit_signal("interrupted_state", "death")
