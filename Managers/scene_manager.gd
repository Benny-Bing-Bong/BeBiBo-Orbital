extends Node

func transition_to_scene(scene_path: String) -> void:
	var err: int = get_tree().change_scene_to_file(scene_path)
	
	if not err == OK:
		print("Error: Unable to change scene")
