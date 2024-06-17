class_name Hurtbox
extends Area2D

# Note: when creating node from this, make sure to set collisions and masks

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(hitbox: Hitbox) -> void:
	if hitbox == null:
		return
	
	# Checks if character with hurtbox is damageable, and if it is,
	#take damage. If theres a hit flash animation, play it
	for child in get_parent().get_children():
		if child is Damageable:
			child.take_damage(hitbox.hit_value)
			print("Damage Taken: " + str(hitbox.hit_value))
		if child is AnimationPlayer:
			child.play("hit")
