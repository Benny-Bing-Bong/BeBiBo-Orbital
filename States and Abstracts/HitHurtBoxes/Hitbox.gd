extends Area2D
class_name Hitbox

@export var hit_value: int = 1 # default to be 1, change if needed

#do we need this since we can manually set it in the inspector for diff things
func _init() -> void:
	collision_layer = 2 # default to be on player, override if needed
	collision_mask = 4 # default to be on enemy, override if needed
