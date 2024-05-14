extends Damageable

func _die() -> void:
	$"../AnimationPlayer".active = false
	await flash_times(3)
	get_parent().queue_free()

func flash_times(times: int) -> void:
	for n in times:
		get_parent().visible = false
		await get_tree().create_timer(0.2).timeout
		get_parent().visible = true
		await get_tree().create_timer(0.2).timeout
