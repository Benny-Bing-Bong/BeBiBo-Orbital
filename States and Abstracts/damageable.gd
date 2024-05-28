class_name Damageable
extends Node

@export var health: int = 3

func take_damage(value: int) -> void:
	health -= value
	
	if health <= 0:
		_die()

# to handle in respective entities
func _die() -> void:
	pass
