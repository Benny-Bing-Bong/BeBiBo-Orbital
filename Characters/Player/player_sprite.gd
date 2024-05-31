extends Sprite2D

func phase_animation() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(self, "modulate:r", 0.0, 0.25)
	tween.parallel().tween_property(self, "modulate:g", 0.0, 0.25)
	tween.parallel().tween_property(self, "modulate:b", 0.0, 0.25)
	
	tween.tween_property(self, "modulate:r", modulate.r, 0.25)
	tween.parallel().tween_property(self, "modulate:g", modulate.g, 0.25)
	tween.parallel().tween_property(self, "modulate:b", modulate.b, 0.25)
