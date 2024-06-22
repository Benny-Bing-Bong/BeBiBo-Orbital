extends Button

@export var button_text: String
@export var checkpoint_name: String

func _ready() -> void:
	# if haven't reached checkpoint yet, make invisible
	if not CheckpointManager.has_reached_checkpoint(checkpoint_name):
		visible = false
		return
	
	text = button_text

func _on_pressed() -> void:
	GameManager.restart_player()
	GameManager.on_main_screen = false
	ScreenManager.remove_all_layers()
	SceneManager.transition_to_scene(checkpoint_name)
