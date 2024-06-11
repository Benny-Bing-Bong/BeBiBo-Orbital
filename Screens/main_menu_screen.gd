extends Control

@onready var load_button: Button = $MarginContainer/VBoxContainer/HBoxContainer2/PanelContainer/MarginContainer/VBoxContainer/LoadButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SaveLoadManager.has_save_file():
		load_button.disabled = false
	else:
		load_button.disabled = true
	
	GameManager.on_main_screen = true

func _on_new_button_pressed() -> void:
	HealthManager.set_health(3)
	GameManager.player_alive = true
	GameManager.on_main_screen = false
	SaveLoadManager.delete_save()
	SceneManager.transition_to_scene("Level1-1")
	
func _on_load_button_pressed() -> void:
	HealthManager.set_health(3)
	GameManager.player_alive = true
	GameManager.on_main_screen = false
	SaveLoadManager.load_game()
	SceneManager.transition_to_scene("Level1-1")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
