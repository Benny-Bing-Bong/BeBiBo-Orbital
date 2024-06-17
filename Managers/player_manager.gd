extends Node

signal on_health_changed(curr_health: int)

# Health Vars
const max_health: int = 3
var curr_health: int

# Phase Vars
var inverted: bool

# Jump Vars
var jumped: bool
var double_jumped: bool

func _ready() -> void:
	curr_health = max_health
	inverted = false
	jumped = false
	double_jumped = false

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

# Jump Functions
func reset_jumps() -> void:
	jumped = false
	double_jumped = false

func can_jump() -> bool:
	return not jumped

func can_double_jump() -> bool:
	return not double_jumped
