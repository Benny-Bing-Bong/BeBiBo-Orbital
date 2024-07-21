extends State

@export var projectile: PackedScene
@export var speed: float

@onready var detection_area: Area2D = $"../../DetectionArea"

@onready var hover_timer: Timer = $HoverTimer
@onready var projectile_timer: Timer = $ProjectileTimer

@onready var left_marker: Marker2D = $"../../LeftMarker"
@onready var right_marker: Marker2D = $"../../RightMarker"

var direction: Vector2
var projectile_left: Node2D
var projectile_right: Node2D

func state_physics_process(delta: float) -> void:
	# hover above player aimlessly
	if hover_timer.is_stopped():
		detection_area.monitoring = false
		detection_area.monitoring = true
		hover_timer.start()
	
	if projectile_timer.is_stopped():
		spawn_projectiles()
		projectile_timer.start()
	
	# face correct direction
	if character.velocity.x > 0:
		anim_sprite.flip_h = true
	else:
		anim_sprite.flip_h = false
	
	# move towards direction facing
	character.velocity = direction * speed * delta
	
	character.move_and_slide()

func instantiate_projectile() -> void:
	projectile_left = projectile.instantiate()
	projectile_right = projectile.instantiate()

func put_at_position() -> void:
	projectile_left.global_position = left_marker.global_position
	projectile_right.global_position = right_marker.global_position

func spawn_projectiles() -> void:
	instantiate_projectile()
	put_at_position()
	character.get_parent().add_child(projectile_left)
	character.get_parent().add_child(projectile_right)

func _on_detection_area_body_entered(body: CharacterBody2D) -> void:
	direction.x = body.global_position.x - character.global_position.x
	direction = direction.normalized()
