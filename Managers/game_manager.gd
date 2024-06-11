extends Node

var player_alive: bool = true
var on_main_screen: bool = false

# load game when launched
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(0.97, 0.74, 0.66, 1.00))

# save the game on quit (by clicking X at top right)
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_WM_CLOSE_REQUEST and not on_main_screen:
		SaveLoadManager.save_game()

func player_died() -> void:
	player_alive = false

func restart_player() -> void:
	player_alive = true
	HealthManager.set_health(3)
