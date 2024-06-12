extends Node

var scenes: Dictionary = {
	"Level1": "res://Levels/level_1.tscn",
	"TestLevel1": "res://Levels/Test Level/test_level.tscn",
	"TestLevel2": "res://Levels/Test Level/test_level_2.tscn",
	"Main": "res://Screens/main_menu_screen.tscn",
	"Level1-1": "res://Levels/Actual Game Levels/level_1-1.tscn",
	"Level1-2": "res://Levels/Actual Game Levels/level_1-2.tscn",
	"Level1-3": "res://Levels/Actual Game Levels/level_1-3.tscn",
	"Level1-4": "res://Levels/Actual Game Levels/level_1-4.tscn",
	"Level1-5": "res://Levels/Actual Game Levels/level_1-5.tscn",
}

func transition_to_scene(scene_name: String) -> void:
	var scene_path: String
	if scenes.has(scene_name):
		scene_path = scenes.get(scene_name)
	else:
		return
	
	var err: int = get_tree().change_scene_to_file(scene_path)
	if not err == OK:
		print("Error: Unable to change scene")
