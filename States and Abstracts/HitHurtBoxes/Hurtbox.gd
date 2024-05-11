extends Area2D
class_name Hurtbox

#do we need this since we can manually set it in the inspector for diff things
func _init() -> void:
	collision_layer = 4 # default to be on enemy, override if needed
	collision_mask = 2 # default to be on player, override if needed

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
	#	if child is Damageable/HealthManager:
	#		child.take_damage(hitbox.hit_value)
	
	
