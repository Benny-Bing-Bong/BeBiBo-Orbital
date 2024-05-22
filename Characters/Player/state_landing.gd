extends State

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == first_anim_name:
		land()

func land() -> void:
	transitioned.emit(self, "ground")
