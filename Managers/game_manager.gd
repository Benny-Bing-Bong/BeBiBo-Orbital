extends Node

var player_alive: bool

# load game when launched
func _ready() -> void:
	SaveLoadManager.load_game()
	player_alive = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and player_alive:
		get_tree().reload_current_scene()
	
	if event.is_action_pressed("reset"):
		HealthManager.set_health(3)
		UnlockManager.reset_unlocks()
		player_alive = true
		get_tree().reload_current_scene()

# save the game on quit (by clicking X at top right)
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_WM_CLOSE_REQUEST:
		SaveLoadManager.save_game()

func player_died() -> void:
	player_alive = false
