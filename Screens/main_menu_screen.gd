extends Control

@export var load_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SaveLoadManager.has_save_file():
		load_button.disabled = false
	else:
		load_button.disabled = true
	
	GameManager.on_main_screen = true
	
	SaveLoadManager.load_settings()
	GameMusic.play_menu_music()

func _on_new_button_pressed() -> void:
	ScreenManager.add_layer_to_screen("new_confirm")
	
func _on_load_button_pressed() -> void:
	# restart player and on_main_screen setting is now in checkpoint_button
	SaveLoadManager.load_game()
	ScreenManager.add_layer_to_screen("checkpoint")

func _on_settings_button_pressed() -> void:
	ScreenManager.add_layer_to_screen("settings")

func _on_credits_button_pressed() -> void:
	SceneManager.transition_to_scene("Credits")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
