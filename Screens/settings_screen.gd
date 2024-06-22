extends CanvasLayer


func _on_audio_button_pressed() -> void:
	ScreenManager.add_layer_to_screen("audio_settings")


func _on_video_button_pressed() -> void:
	ScreenManager.add_layer_to_screen("video_settings")


func _on_back_button_pressed() -> void:
	ScreenManager.remove_layer_from_screen()
