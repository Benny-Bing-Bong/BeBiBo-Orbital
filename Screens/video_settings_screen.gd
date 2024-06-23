extends CanvasLayer

@onready var display_button: OptionButton = %DisplayButton
@onready var resolution_button: OptionButton = %ResolutionButton

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

func _ready() -> void:
	for r: String in RESOLUTIONS:
		resolution_button.add_item(r)
	
	for d: String in DISPLAY_MODES:
		display_button.add_item(d)
	
	resolution_button.selected = RESOLUTIONS.keys().find(
			SettingsManager.resolution)
	display_button.selected = DISPLAY_MODES.keys().find(
			SettingsManager.display_mode)
	
	if not (SettingsManager.get_display_mode_index() 
			== DisplayServer.WINDOW_MODE_WINDOWED):
		resolution_button.disabled = true

func _on_resolution_button_item_selected(index: int) -> void:
	DisplayServer.window_set_size(RESOLUTIONS.values()[index])
	
	SettingsManager.resolution = RESOLUTIONS.keys()[index]
	
	#user_settings.resolution = RESOLUTIONS.values()[index]
	SaveLoadManager.save_settings()

func _on_display_button_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(
				DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		resolution_button.disabled = true
	elif index == 1:
		DisplayServer.window_set_mode(
				DisplayServer.WINDOW_MODE_FULLSCREEN)
		resolution_button.disabled = true
	elif index == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(SettingsManager.get_resolution_size())
		resolution_button.disabled = false
	
	SettingsManager.display_mode = DISPLAY_MODES.keys()[index]
	#user_settings.display_mode = 4 - index
	SaveLoadManager.save_settings()
