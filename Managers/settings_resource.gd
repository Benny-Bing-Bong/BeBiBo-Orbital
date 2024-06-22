class_name UserSettings extends Resource

@export_range(0, 1, 0.05) var master_audio_level: float = 1.0
@export_range(0, 1, 0.05) var music_audio_level: float = 1.0
@export_range(0, 1, 0.05) var sfx_audio_level: float = 1.0

@export var resolution: Vector2i = Vector2i(640, 360)
@export var display_mode: int = 4
