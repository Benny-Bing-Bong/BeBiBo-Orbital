extends Node

signal on_health_changed(curr_health: int)

# Health Vars
const max_health: int = 3
var curr_health: int

# Phase Vars
var inverted: bool

func _ready() -> void:
	curr_health = max_health
	inverted = false

# Health Functions
func set_health(new_value: int) -> void:
	curr_health = new_value
	
	# clamp curr_health to 0 and 3
	if curr_health < 0:
		curr_health = 0
	
	if curr_health > max_health:
		curr_health = max_health
	
	on_health_changed.emit(curr_health)

# Health Functions
func phase_shift() -> void:
	inverted = not inverted

func is_anti() -> bool:
	return inverted
