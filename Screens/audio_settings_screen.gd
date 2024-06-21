extends CanvasLayer

@onready var MASTER_INDEX: int = AudioServer.get_bus_index("Master")
@onready var MUSIC_INDEX: int = AudioServer.get_bus_index("Music")
@onready var SFX_INDEX: int = AudioServer.get_bus_index("SFX")

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MASTER_INDEX, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_INDEX, value < 0.05)

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_INDEX, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_INDEX, value < 0.05)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_INDEX, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_INDEX, value < 0.05)
