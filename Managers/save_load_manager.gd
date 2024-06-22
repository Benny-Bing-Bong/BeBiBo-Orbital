extends Node

@onready var MASTER_INDEX: int = AudioServer.get_bus_index("Master")
@onready var MUSIC_INDEX: int = AudioServer.get_bus_index("Music")
@onready var SFX_INDEX: int = AudioServer.get_bus_index("SFX")

var settings_file_path: String = "user://user_settings.tres"
var game_file_path: String = "user://save_file.tres"

func load_settings() -> UserSettings:
	var saved: UserSettings = load(settings_file_path) as UserSettings
	
	if not saved:
		saved = UserSettings.new()
	
	var master_volume: float = linear_to_db(saved.master_audio_level)
	AudioServer.set_bus_volume_db(MASTER_INDEX, master_volume)
	
	var music_volume: float = linear_to_db(saved.music_audio_level)
	AudioServer.set_bus_volume_db(MUSIC_INDEX, music_volume)
	
	var sfx_volume: float = linear_to_db(saved.sfx_audio_level)
	AudioServer.set_bus_volume_db(SFX_INDEX, sfx_volume)
	
	DisplayServer.window_set_mode(saved.display_mode)
	
	return saved

func save_settings() -> void:
	var to_save: UserSettings = load_settings()
	ResourceSaver.save(to_save, settings_file_path)

func save_game() -> void:
	var to_save: SaveLoadResource = SaveLoadResource.new()
	
	to_save.unlock_dictionary = UnlockManager.save_dictionary()
	to_save.checkpoint_dictionary = CheckpointManager.save_dictionary()
	
	ResourceSaver.save(to_save, game_file_path)

func load_game() -> void:
	var saved: SaveLoadResource = load(game_file_path) as SaveLoadResource
	
	# check if saved file exists. if not, create one now
	if not saved:
		save_game()
		saved = load(game_file_path) as SaveLoadResource
	
	UnlockManager.load_dictionary(saved.unlock_dictionary)
	CheckpointManager.load_dictionary(saved.checkpoint_dictionary)

func has_save_file() -> bool:
	var saved: SaveLoadResource = load(game_file_path)
	
	if not saved:
		return false
	else:
		return true

func delete_save() -> void:
	# reset all the current saved in the current instance of game
	UnlockManager.reset_unlocks()
	CheckpointManager.reset_checkpoints()
	
	# delete actual save file
	DirAccess.remove_absolute(game_file_path)
	
