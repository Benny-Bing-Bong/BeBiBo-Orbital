extends Hurtbox

func on_area_entered(hitbox: Hitbox) -> void:
	super(hitbox)
	if hitbox is ProjectileHitbox:
		if 
