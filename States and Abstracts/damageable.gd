class_name Damageable
extends Node

@export var health: int = 3

func take_damage(value: int) -> void:
	health -= value
	
	if health <= 0:
		_die()

# to handle in respective entities
func _die() -> void:
	if not get_parent():
		return
	
	for child in get_parent().get_children():
		if child is Hitbox:
			child.queue_free()
		if child is Hurtbox:
			child.queue_free()
