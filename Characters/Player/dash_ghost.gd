extends Sprite2D

func _ready() -> void:
	var tween: Tween = create_tween()
	# Set transition and ease for following tweens
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	# Tween to execute
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	# Remove from level scebe once tween is executed
	await tween.finished
	queue_free()
