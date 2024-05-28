extends Node

var file_path: String = "user://save_file.tres"

func save_game() -> void:
	var to_save: SaveLoadResource = SaveLoadResource.new()
	
	to_save.unlock_dictionary = UnlockManager.unlock_dictionary
	
	ResourceSaver.save(to_save, file_path)

func load_game() -> void:
	var saved: SaveLoadResource = load(file_path) as SaveLoadResource
	
	# check if saved file exists. if not, create one now
	if not saved:
		save_game()
		saved = load(file_path) as SaveLoadResource
	
	UnlockManager.unlock_dictionary = saved.unlock_dictionary
