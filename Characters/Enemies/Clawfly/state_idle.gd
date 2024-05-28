extends State

@onready var detection_area: Area2D = $"../../DetectionArea"

var speed: float = 200.0
var direction: Vector2

func enter() -> void:
	super()
	# reset monitoring property of detection_area to allow tracking of player's 
	# position by enemy if player is still in detection area
	detection_area.monitoring = false
	detection_area.monitoring = true

func _on_detection_area_body_entered(body: Node2D) -> void:
	character.velocity = body.global_position - character.global_position
	character.velocity = character.velocity.normalized()
		
	warning()

func warning() -> void:
	transitioned.emit(self, "warning")
