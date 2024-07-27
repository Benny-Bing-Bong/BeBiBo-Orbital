extends CanvasLayer

func _on_yes_button_pressed() -> void:
	GameManager.restart_player()
	GameManager.on_main_screen = false
	SaveLoadManager.delete_save()
	ScreenManager.remove_all_layers()
	SceneManager.transition_to_scene("Workshop")

func _on_no_button_pressed() -> void:
	ScreenManager.remove_layer_from_screen()
