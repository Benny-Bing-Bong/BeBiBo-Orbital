extends CanvasLayer

@onready var resolution_button: OptionButton = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/ResolutionButton
@onready var display_button:  OptionButton = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/GridContainer/DisplayButton


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
	"Bordered Windowed": DisplayServer.WINDOW_MODE_MAXIMIZED
}

var user_settings: UserSettings

func _ready() -> void:
	for r: String in RESOLUTIONS:
		resolution_button.add_item(r)
	
	for d: String in DISPLAY_MODES:
		display_button.add_item(d)
	
	user_settings = SaveLoadManager.load_settings()
	
	display_button.selected = 4 - user_settings.display_mode

func _on_resolution_button_item_selected(index: int) -> void:
	DisplayServer.window_set_size(RESOLUTIONS.values()[index])
	
	user_settings.resolution = RESOLUTIONS.values()[index]
	SaveLoadManager.save_settings()


func _on_display_button_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	elif index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif index == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	
	user_settings.display_mode = 4 - index
	SaveLoadManager.save_settings()


func _on_back_button_pressed() -> void:
	ScreenManager.remove_layer_from_screen()
