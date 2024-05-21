extends Node

const max_health: int = 3
var curr_health: int

signal on_health_changed(curr_health: int)

func _ready() -> void:
	curr_health = max_health

func set_health(new_value: int) -> void:
	curr_health = new_value
	
	# clamp curr_health to 0 and 3
	if curr_health < 0:
		curr_health = 0
	
	if curr_health > max_health:
		curr_health = max_health
	
	on_health_changed.emit(curr_health)
