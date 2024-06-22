extends Control

@export var load_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SaveLoadManager.has_save_file():
		load_button.disabled = false
	else:
		load_button.disabled = true
	
	GameManager.on_main_screen = true

func _on_new_button_pressed() -> void:
	GameManager.restart_player()
	GameManager.on_main_screen = false
	SaveLoadManager.delete_save()
	SceneManager.transition_to_scene("Level1-1")
	
func _on_load_button_pressed() -> void:
	# restart player and on_main_screen setting is now in checkpoint_button
	SaveLoadManager.load_game()
	ScreenManager.add_layer_to_screen("checkpoint")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
