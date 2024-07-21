extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var detection_area: Area2D = $DetectionArea

var target: CharacterBody2D
var speed: float = 100

func _ready() -> void:
	animated_sprite_2d.play()

func _physics_process(delta: float) -> void:
	if target:
		navigation_agent_2d.target_position = target.global_position
		
	if navigation_agent_2d.is_navigation_finished():
		return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent_2d.get_next_path_position()
	var new_velocity: Vector2 = current_agent_position.direction_to(next_path_position) * speed
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)
		
	move_and_slide()

func _on_detection_area_body_entered(body: CharacterBody2D) -> void:
	target = body


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity


func _on_timer_timeout() -> void:
	var tween: Tween = animated_sprite_2d.create_tween()
	# Set transition and ease for following tweens
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN)
	# Tween to execute
	tween.tween_property(self, "modulate:a", 0.0, 0.2)
	# Remove from level scebe once tween is executed
	await tween.finished
	queue_free()


func _on_projectile_hitbox_body_entered(body: CharacterBody2D) -> void:
	_on_timer_timeout()
