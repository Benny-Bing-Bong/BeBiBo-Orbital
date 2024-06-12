extends Node

var file_path: String = "user://save_file.tres"

func save_game() -> void:
	var to_save: SaveLoadResource = SaveLoadResource.new()
	
	to_save.unlock_dictionary = UnlockManager.save_dictionary()
	
	ResourceSaver.save(to_save, file_path)

func load_game() -> void:
	var saved: SaveLoadResource = load(file_path) as SaveLoadResource
	
	# check if saved file exists. if not, create one now
	if not saved:
		save_game()
		saved = load(file_path) as SaveLoadResource
	
	UnlockManager.load_dictionary(saved.unlock_dictionary)

func has_save_file() -> bool:
	var saved: SaveLoadResource = load(file_path)
	
	if not saved:
		return false
	else:
		return true

func delete_save() -> void:
	# reset all the current saved in the current instance of game
	UnlockManager.reset_unlocks()
	
	# delete actual save file
	DirAccess.remove_absolute(file_path)
	
