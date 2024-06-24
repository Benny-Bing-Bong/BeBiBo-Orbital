extends CanvasLayer

func _on_audio_button_pressed() -> void:
	ScreenManager.add_layer_to_screen("audio_settings")

func _on_video_button_pressed() -> void:
	ScreenManager.add_layer_to_screen("video_settings")

func _on_keybinds_button_pressed() -> void:
	ScreenManager.add_layer_to_screen("keybind_settings")
