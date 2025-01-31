extends Node

var player_alive: bool = true
var on_main_screen: bool = true

var debug_mode: bool = true

# load game when launched
func _ready() -> void:
	#RenderingServer.set_default_clear_color(Color(0.97, 0.74, 0.66, 1.00))
	RenderingServer.set_default_clear_color(Color(0, 0, 0, 1.00))
	
	# load game and settings on launch first
	if debug_mode:
		SaveLoadManager.load_game() 
		SaveLoadManager.load_settings()

# save the game on quit (by clicking X at top right)
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_WM_CLOSE_REQUEST and not on_main_screen:
		SaveLoadManager.save_game()

func player_died() -> void:
	player_alive = false

func restart_player() -> void:
	player_alive = true
	PlayerManager.set_health(3)
