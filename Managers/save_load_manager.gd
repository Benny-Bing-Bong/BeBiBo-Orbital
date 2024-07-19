extends Node

var settings_file_path: String = "user://user_settings.tres"
var game_file_path: String = "user://save_file.tres"

func load_settings() -> void:
	var saved: UserSettings = load(settings_file_path) as UserSettings
	
	if not saved:
		saved = UserSettings.new()
	
	SettingsManager.load_settings(saved)

func save_settings() -> void:
	var to_save: UserSettings = UserSettings.new()
	
	# save audio settings
	to_save.master_audio_level = SettingsManager.master_audio_level
	to_save.music_audio_level = SettingsManager.music_audio_level
	to_save.sfx_audio_level = SettingsManager.sfx_audio_level
	
	# save video settings
	to_save.resolution = SettingsManager.resolution
	to_save.display_mode = SettingsManager.display_mode
	
	# save input mappings
	for action: String in to_save.saved_inputs:
		to_save.saved_inputs[action] = SettingsManager.INPUT_MAPPINGS[action]
	
	ResourceSaver.save(to_save, settings_file_path)

func save_game() -> void:
	var to_save: SaveLoadResource = SaveLoadResource.new()
	
	to_save.unlock_dictionary = UnlockManager.save_dictionary()
	to_save.checkpoint_dictionary = CheckpointManager.save_dictionary()
	to_save.mechanic_dialogue_dictionary = MDM.save_dictionary()
	to_save.sidequest_dictionary = DSM.save_sidequest_dict()
	to_save.interactions_dictionary = DSM.save_inter_dict()
	
	ResourceSaver.save(to_save, game_file_path)

func load_game() -> void:
	var saved: SaveLoadResource = load(game_file_path) as SaveLoadResource
	
	# check if saved file exists. if not, create one now
	if not saved:
		save_game()
		saved = load(game_file_path) as SaveLoadResource
	
	UnlockManager.load_dictionary(saved.unlock_dictionary)
	CheckpointManager.load_dictionary(saved.checkpoint_dictionary)
	MDM.load_dictionary(saved.mechanic_dialogue_dictionary)
	DSM.load_sidequest_dict(saved.sidequest_dictionary)
	DSM.load_inter_dict(saved.interactions_dictionary)

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
	MDM.reset_mechanic_dialogue()
	DSM.reset_dialogue_states()
	
	# delete actual save file
	DirAccess.remove_absolute(game_file_path)
	
