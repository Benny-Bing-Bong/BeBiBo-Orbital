extends CanvasLayer

func _on_resume_button_pressed() -> void:
	ScreenManager.remove_layer_from_screen()

func _on_restart_button_pressed() -> void:
	GameManager.restart_player()
	ScreenManager.remove_all_layers()
	SceneManager.transition_to_scene("Workshop")

func _on_checkpoint_button_pressed() -> void:
	ScreenManager.add_layer_to_screen("checkpoint")

func _on_unlocks_button_pressed() -> void:
	ScreenManager.add_layer_to_screen("unlocks")

func _on_main_button_pressed() -> void:
	ScreenManager.remove_layer_from_screen()
	SaveLoadManager.save_game()
	SceneManager.transition_to_scene("Main")

func _on_quit_button_pressed() -> void:
	SaveLoadManager.save_game()
	get_tree().quit()


func _on_settings_button_pressed() -> void:
	ScreenManager.add_layer_to_screen("settings")
