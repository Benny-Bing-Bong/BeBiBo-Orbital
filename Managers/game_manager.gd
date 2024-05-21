extends Node

var player_alive: bool

func _ready() -> void:
	player_alive = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and player_alive:
		get_tree().reload_current_scene()
	
	if event.is_action_pressed("reset"):
		HealthManager.set_health(3)
		player_alive = true
		get_tree().reload_current_scene()

func player_died() -> void:
	player_alive = false
