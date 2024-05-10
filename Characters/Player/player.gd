extends CharacterBody2D
class_name Player

@export var speed: float = 200.0

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation_parameters()
	update_facing_direction()

func update_animation_parameters() -> void:
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_facing_direction() -> void:
	var slash1_hitbox: CollisionShape2D = $Hitbox/Slash1ColShape2D
	var slash2_hitbox: CollisionShape2D = $Hitbox/Slash2ColShape2D
	var distance1: float = abs(slash1_hitbox.global_position.x - global_position.x)
	var distance2: float = abs(slash2_hitbox.global_position.x - global_position.x)
	
	if direction.x > 0:
		sprite.flip_h = false
		slash1_hitbox.position.x = distance1
		slash2_hitbox.position.x = distance2
	elif direction.x < 0:
		sprite.flip_h = true
		slash1_hitbox.position.x = -distance1
		slash2_hitbox.position.x = -distance2
