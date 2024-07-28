extends State

@onready var timer: Timer = $Timer
@onready var detection_area: Area2D = $"../../DetectionArea"

var speed: float = 9000.0
var direction: Vector2

func enter() -> void:
	super()
	detection_area.monitoring = false
	detection_area.monitoring = true
	timer.start()

func state_physics_process(delta: float) -> void:
	
	if character.velocity.x > 0:
		anim_sprite.flip_h = true
	else:
		anim_sprite.flip_h = false
		
	character.velocity = direction * speed * delta
	
	character.move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	direction = body.global_position - character.global_position
	direction = direction.normalized()


func _on_timer_timeout() -> void:
	transitioned.emit(self, "cooldown")
