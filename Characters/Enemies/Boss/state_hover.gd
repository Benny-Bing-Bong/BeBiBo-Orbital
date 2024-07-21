extends State

@onready var detection_area: Area2D = $"../../DetectionArea"
@onready var hover_timer: Timer = $HoverTimer

var speed: float = 9000.0
var direction: Vector2

func state_physics_process(delta: float) -> void:
	if hover_timer.is_stopped():
		detection_area.monitoring = false
		detection_area.monitoring = true
		hover_timer.start()
	
	if character.velocity.x > 0:
		anim_sprite.flip_h = true
	else:
		anim_sprite.flip_h = false
		
	character.velocity = direction * speed * delta
	
	character.move_and_slide()

func _on_detection_area_body_entered(body: CharacterBody2D) -> void:
	direction.x = body.global_position.x - character.global_position.x
	direction = direction.normalized()
