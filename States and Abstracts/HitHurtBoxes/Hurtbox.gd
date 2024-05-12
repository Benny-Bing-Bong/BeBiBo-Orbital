extends Area2D
class_name Hurtbox

# Note: when creating node from this, make sure to set collisions and masks

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(hitbox: Hitbox) -> void:
	if hitbox == null:
		return
	
	#For testing
	print(str(hitbox.hit_value) + " damage taken by " + get_parent().get_name())
	get_parent().take_damage(hitbox.hit_value)
	print("Total damage taken so far: " + str(get_parent().get_total_damage()) + "\n")
	
	#Once Damageable/HealthManager script is created
	#for child in get_parent().get_children():
		#if child is Damageable/HealthManager:
			#child.take_damage(hitbox.hit_value)
	
	
