extends Node

@export_range(0, 1, 0.05) var master_audio_level: float = 1.0
@export_range(0, 1, 0.05) var music_audio_level: float = 1.0
@export_range(0, 1, 0.05) var sfx_audio_level: float = 1.0
var resolution: String = "1280 x 720"
var display_mode: String = "Fullscreen"

var RESOLUTIONS: Dictionary = {
	"1920 x 1080": Vector2i(1920, 1080),
	"1280 x 720": Vector2i(1280, 720),
	"640 x 360": Vector2i(640, 360),
	"480 x 240": Vector2i(480, 240),
	"320 x 180": Vector2i(320, 180)
}
var DISPLAY_MODES: Dictionary = {
	"Fullscreen": DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN,
	"Borderless Windowed": DisplayServer.WINDOW_MODE_FULLSCREEN,
	"Bordered Windowed": DisplayServer.WINDOW_MODE_WINDOWED
}
@onready var MASTER_INDEX: int = AudioServer.get_bus_index("Master")
@onready var MUSIC_INDEX: int = AudioServer.get_bus_index("Music")
@onready var SFX_INDEX: int = AudioServer.get_bus_index("SFX")

func load_settings(resource: UserSettings) -> void:
	master_audio_level = resource.master_audio_level
	music_audio_level = resource.music_audio_level
	sfx_audio_level = resource.sfx_audio_level
	
	resolution = resource.resolution
	display_mode = resource.display_mode
	
	var master_volume: float = linear_to_db(master_audio_level)
	AudioServer.set_bus_volume_db(MASTER_INDEX, master_volume)
	
	var music_volume: float = linear_to_db(music_audio_level)
	AudioServer.set_bus_volume_db(MUSIC_INDEX, music_volume)
	
	var sfx_volume: float = linear_to_db(sfx_audio_level)
	AudioServer.set_bus_volume_db(SFX_INDEX, sfx_volume)
	
	DisplayServer.window_set_mode(DISPLAY_MODES.get(display_mode))
	DisplayServer.window_set_size(RESOLUTIONS.get(resolution))

func get_resolution_size() -> Vector2i:
	return RESOLUTIONS.get(resolution)

func get_display_mode_index() -> int:
	return DISPLAY_MODES.get(display_mode)
