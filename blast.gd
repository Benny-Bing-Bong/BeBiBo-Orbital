extends Sprite2D

@export var hitbox: Hitbox

const ANTI_PLAYER_COLLISION: int = 16
const ANTI_ENEMY_WORLD_MASK: int = 33

func _ready() -> void:
	var tween: Tween = create_tween()
	# Set transition and ease for following tweens
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_OUT)
	# Tween to execute
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	# Remove from level scebe once tween is executed
	await tween.finished
	queue_free()

func change_to_anti() -> void:
	hitbox.collision_layer = ANTI_PLAYER_COLLISION
	hitbox.collision_mask = ANTI_ENEMY_WORLD_MASK
	# no need to handle shader because using player shader
