extends GutTest

var parent: Node
var damageable: Damageable
var hurtbox: Hurtbox
var hitbox: Hitbox

func before_all() -> void:
	hitbox = Hitbox.new()

func before_each() -> void:
	parent = Node.new()
	damageable = Damageable.new()
	hurtbox = Hurtbox.new()
	
	parent.add_child(damageable)
	parent.add_child(hurtbox)
	
	autofree(parent)

func after_all() -> void:
	hitbox.free()

func test_hurtbox_area_entered_damageable_take_damage() -> void:
	var first_health: int = damageable.health
	hurtbox.on_area_entered(hitbox)
	var second_health: int = damageable.health
	
	assert_lt(second_health, first_health)
