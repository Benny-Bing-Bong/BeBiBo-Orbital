extends Area2D
class_name DetectionArea

@onready var timer: Timer = $Timer

@export var character: CharacterBody2D
@export var anim_sprite: AnimatedSprite2D

@onready var player: Node2D
var direction: Vector2


func _on_timer_timeout() -> void:
	monitoring = false
	monitoring = true


func _on_body_entered(body: Node2D) -> void:
	player = body
	
	if timer.is_stopped():
		timer.start()
	
	for child in get_parent().get_children():
		if child is EnemyStateMachine:
			child.emit_signal("interrupt_state", "warning")
