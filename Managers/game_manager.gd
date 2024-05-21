extends Node

# TODO: on restart, need to save new player data such as health to reset it 
#back to full health before reloading scene. Probably will change the event
#to be some button press instead
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
