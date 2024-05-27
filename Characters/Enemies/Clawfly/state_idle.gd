extends State

@onready var detection_area: Area2D = $"../../DetectionArea"

var speed: float = 200.0
var direction: Vector2

func enter() -> void:
	super()
	detection_area.monitoring = false
	detection_area.monitoring = true


func _on_detection_area_body_entered(body: Node2D) -> void:
	character.velocity = body.global_position - character.global_position
	character.velocity = character.velocity.normalized()
		
	warning()

func warning() -> void:
	transitioned.emit(self, "warning")
