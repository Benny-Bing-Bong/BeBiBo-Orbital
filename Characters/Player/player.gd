extends CharacterBody2D
class_name Player

@export var speed: float = 200.0

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D
@onready var sword: Area2D = $Sword

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
	var sword_col_shape: CollisionShape2D = sword.get_node("CollisionShape2D")
	var dist: float = abs($CollisionShape2D.position.x - sword_col_shape.position.x)
	print(dist)
	
	if direction.x > 0:
		sprite.flip_h = false
		sword_col_shape.position.x = dist
	elif direction.x < 0:
		sprite.flip_h = true
		sword_col_shape.position.x = -dist
