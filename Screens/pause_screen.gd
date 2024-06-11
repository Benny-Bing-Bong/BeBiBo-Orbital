extends CanvasLayer

func _on_resume_button_pressed() -> void:
	ScreenManager.remove_layer_from_screen()

func _on_main_button_pressed() -> void:
	ScreenManager.remove_layer_from_screen()
	SceneManager.transition_to_scene("Main")
