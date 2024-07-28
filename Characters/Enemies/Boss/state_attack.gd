extends State

@export var speed: float = 4000

@onready var detection_area: Area2D = $"../../DetectionArea"
@onready var timer: Timer = $Timer

var target: CharacterBody2D
var target_pos: Vector2

var direction: Vector2

func enter() -> void:
	super()
	timer.start()
	detection_area.monitoring = false
	detection_area.monitoring = true

func state_physics_process(delta: float) -> void:
	if character.velocity.x > 0:
		anim_sprite.flip_h = true
	else:
		anim_sprite.flip_h = false

	character.velocity = direction * speed * delta
	character.move_and_slide()

func _on_detection_area_body_entered(body: CharacterBody2D) -> void:
	target = body
	target_pos = target.global_position
	direction = target_pos - character.global_position
	direction = direction.normalized()
