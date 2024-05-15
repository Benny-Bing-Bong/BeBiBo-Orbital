extends Damageable

@onready var timer: Timer = $Timer

func take_damage(value: int) -> void:
	for child in get_parent().get_children():
		if child is EnemyStateMachine:
			if health - value <= 0:
				child.emit_signal("interrupt_state", "dead")
			else:
				child.emit_signal("interrupt_state", "knockback")
	super.take_damage(value)

func _die() -> void:
		if timer.is_stopped():
			timer.start()

func flash_times(times: int) -> void:
	for n in times:
		get_parent().visible = false
		await get_tree().create_timer(0.2).timeout
		get_parent().visible = true
		await get_tree().create_timer(0.2).timeout



func _on_timer_timeout() -> void:
	await flash_times(3)
	get_parent().queue_free()
