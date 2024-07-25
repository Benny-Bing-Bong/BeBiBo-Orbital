extends State


func _on_animated_sprite_2d_animation_finished() -> void:
	transitioned.emit(self, "attack")
