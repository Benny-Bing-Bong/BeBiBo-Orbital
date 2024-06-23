extends CanvasLayer

@onready var MASTER_INDEX: int = AudioServer.get_bus_index("Master")
@onready var MUSIC_INDEX: int = AudioServer.get_bus_index("Music")
@onready var SFX_INDEX: int = AudioServer.get_bus_index("SFX")
@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider

func _ready() -> void:
	master_slider.value = SettingsManager.master_audio_level
	music_slider.value = SettingsManager.music_audio_level
	sfx_slider.value = SettingsManager.sfx_audio_level

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MASTER_INDEX, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_INDEX, value < 0.05)
	
	SettingsManager.master_audio_level = value
	SaveLoadManager.save_settings()

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_INDEX, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_INDEX, value < 0.05)
	
	SettingsManager.music_audio_level = value
	SaveLoadManager.save_settings()

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_INDEX, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_INDEX, value < 0.05)
	
	SettingsManager.sfx_audio_level = value
	SaveLoadManager.save_settings()
