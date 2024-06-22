extends Sprite2D

const ANTI_PLAYER_COLLISION: int = 16
const ANTI_ENEMY_WORLD_MASK: int = 545

@export var hitbox: Hitbox

var laser_speed: int = 1000

func change_to_anti() -> void:
	hitbox.collision_layer = ANTI_PLAYER_COLLISION
	hitbox.collision_mask = ANTI_ENEMY_WORLD_MASK
	# no need to handle shader because using player shader

func _physics_process(delta: float) -> void:
	move_local_x(laser_speed * delta)

# remove laser after 1 second
func _on_remove_timer_timeout() -> void:
	queue_free()

# remove laser when it collides with the world or enemies (no pierce)
func _on_hitbox_area_entered(area: Area2D) -> void:
	queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	queue_free()
