extends Node

var scenes: Dictionary = {
	"Level1": "res://Levels/level_1.tscn",
	"TestLevel1": "res://Levels/Test Level/test_level.tscn",
	"TestLevel2": "res://Levels/Test Level/test_level_2.tscn",
	"Level1-1": "res://Levels/Actual Game Levels/level_1-1.tscn"
}

func transition_to_scene(scene_name: String) -> void:
	var scene_path: String = scenes.get(scene_name)
	if scene_path == null:
		return
	
	var err: int = get_tree().change_scene_to_file(scene_path)
	if not err == OK:
		print("Error: Unable to change scene")
