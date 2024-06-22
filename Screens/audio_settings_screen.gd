extends CanvasLayer

@onready var MASTER_INDEX: int = AudioServer.get_bus_index("Master")
@onready var MUSIC_INDEX: int = AudioServer.get_bus_index("Music")
@onready var SFX_INDEX: int = AudioServer.get_bus_index("SFX")
@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider

var user_settings: UserSettings

func _ready() -> void:
	user_settings = SaveLoadManager.load_settings()
	
	if master_slider:
		master_slider.value = user_settings.master_audio_level
	
	if music_slider:
		music_slider.value = user_settings.music_audio_level
	
	if sfx_slider:
		sfx_slider.value = user_settings.sfx_audio_level

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MASTER_INDEX, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_INDEX, value < 0.05)
	
	if user_settings:
		user_settings.master_audio_level = value
		SaveLoadManager.save_settings()

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_INDEX, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_INDEX, value < 0.05)
	
	if user_settings:
		user_settings.music_audio_level = value
		SaveLoadManager.save_settings()

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_INDEX, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_INDEX, value < 0.05)
	
	if user_settings:
		user_settings.sfx_audio_level = value
		SaveLoadManager.save_settings()


func _on_back_button_pressed() -> void:
	ScreenManager.remove_layer_from_screen()
