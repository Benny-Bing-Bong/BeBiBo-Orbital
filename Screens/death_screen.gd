extends CanvasLayer


func _on_restart_button_pressed() -> void:
	GameManager.restart_player()
	ScreenManager.remove_all_layers()
	SceneManager.transition_to_scene("Level1-1")

func _on_quit_button_pressed() -> void:
	SaveLoadManager.save_game()
	get_tree().quit()
