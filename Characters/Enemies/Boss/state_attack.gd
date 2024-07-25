extends State

@onready var detection_area: Area2D = $"../../DetectionArea"

var target: CharacterBody2D

func enter() -> void:
	super()
	detection_area.monitoring = false
	detection_area.monitoring = true

func _on_detection_area_body_entered(body: CharacterBody2D) -> void:
	target = body
