extends Node

@onready var phase_cooldown: Timer = $PhaseCooldown
@onready var laser_cooldown: Timer = $LaserCooldown

@onready var cooldown_names: Dictionary = {
		"phase": phase_cooldown,
		"laser": laser_cooldown,
}

func start_cooldown(name: String) -> void:
	var timer: Timer = cooldown_names.get(name)
	
	if timer:
		timer.start()

func skill_ready(name: String) -> bool:
	var timer: Timer = cooldown_names[name]
	
	if timer:
		return timer.is_stopped()
	
	return false # default: return false, meaning skill is still on cooldown

func get_remaining_time(name: String) -> float:
	var timer: Timer = cooldown_names[name]
	
	if timer:
		return timer.time_left
	
	return 0.0
