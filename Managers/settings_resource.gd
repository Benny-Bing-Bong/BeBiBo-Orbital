class_name UserSettings extends Resource

@export_range(0, 1, 0.05) var master_audio_level: float = 1.0
@export_range(0, 1, 0.05) var music_audio_level: float = 1.0
@export_range(0, 1, 0.05) var sfx_audio_level: float = 1.0

@export var resolution: String = "1280 x 720"
@export var display_mode: String = "Fullscreen"

@export var saved_inputs: Dictionary = {
	"left": InputMap.action_get_events("left")[0],
	"right": InputMap.action_get_events("right")[0],
	"interact": InputMap.action_get_events("interact")[0],
	"attack": InputMap.action_get_events("attack")[0],
	"up": InputMap.action_get_events("up")[0],
	"down": InputMap.action_get_events("down")[0],
	"dash": InputMap.action_get_events("dash")[0],
	"phaseshift": InputMap.action_get_events("phaseshift")[0],
	"laser": InputMap.action_get_events("laser")[0],
	"bomb": InputMap.action_get_events("bomb")[0],
	"unlocks": InputMap.action_get_events("unlocks")[0],
	"close": InputMap.action_get_events("close")[0],
}
