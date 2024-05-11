extends State

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == first_anim_name:
		transitioned.emit(self, "ground")

#func state_input(input: InputEvent) -> void: # to manually transition back to ground
	#if input.is_action_pressed("down"):
		#transitioned.emit(self, "ground")
