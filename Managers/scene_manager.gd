extends Node

signal enemies_cleared()
signal enemies_changed(number: int)

var enemies_left: int:
	get:
		return enemies_left
	set(value):
		if enemies_left != value:
			enemies_left = value
			enemies_changed.emit(value)
		
		if value == 0:
			enemies_cleared.emit()


var scenes: Dictionary = {
	"Level1": "res://Levels/level_1.tscn",
	"TestLevel1": "res://Levels/Test Level/test_level.tscn",
	"TestLevel2": "res://Levels/Test Level/test_level_2.tscn",
	"Main": "res://Screens/main_menu_screen.tscn",
	"Workshop": "res://Levels/Actual Game Levels/workshop.tscn",
	"Level1-1": "res://Levels/Actual Game Levels/level_1-1.tscn",
	"Level1-2": "res://Levels/Actual Game Levels/level_1-2.tscn",
	"Level1-3": "res://Levels/Actual Game Levels/level_1-3.tscn",
	"Level1-4": "res://Levels/Actual Game Levels/level_1-4.tscn",
	"Level1-5": "res://Levels/Actual Game Levels/level_1-5.tscn",
	"Level2-1": "res://Levels/Actual Game Levels/level_2_1.tscn",
	"Level2-2": "res://Levels/Actual Game Levels/level_2_2.tscn",
	"Level2-3": "res://Levels/Actual Game Levels/level_2_3.tscn",
	"HubLevel": "res://Levels/Actual Game Levels/hub_level.tscn",
	"BefBossLevel": "res://Levels/Actual Game Levels/bef_boss_level.tscn",
	"BossLevel": "res://Levels/Actual Game Levels/boss_level.tscn",
	"Ending": "res://Levels/Ending Scenes/ending_scene.tscn",
	"Credits": "res://Levels/Credits Scene/credits_scene.tscn",
	"Splash2": "res://Levels/SplashArt/splash_art_2.tscn",
}

func transition_to_scene(scene_name: String) -> void:
	var scene_path: String
	if scenes.has(scene_name):
		scene_path = scenes.get(scene_name)
		# try to unlock checkpoint on every level change
		CheckpointManager.update_checkpoint(scene_name)
	else:
		return
	
	# Make sure enemies becomes 0 when going back to main to prevent bugs
	if scene_name == "Main":
		enemies_left = 0
	
	# this is in case there are any levels with no enemies, and for level resets
	enemies_left += 500
	
	var err: int = get_tree().change_scene_to_file(scene_path)
	if not err == OK:
		print("Error: Unable to change scene")
	
	# show platforming dialogue when reaching level 2-1
	if scene_name == "Level2-1":
		await get_tree().create_timer(1).timeout
		MDM.try_dialogue("platforming")

func update_enemies_left(number: int) -> void:
	enemies_left = number
