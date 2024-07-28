extends CharacterBody2D

@onready var character: CharacterBody2D = $"."
@onready var detection_area: Area2D = $DetectionArea
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D


var speed: float = 9000.0
var direction: Vector2

func _physics_process(delta: float) -> void:
	# keep updating direction so that clawfly follows player
	detection_area.monitoring = false
	detection_area.monitoring = true
	
	if character.velocity.x > 0:
		anim_sprite.flip_h = true
	else:
		anim_sprite.flip_h = false
		
	character.velocity = direction * speed * delta
	
	character.move_and_slide()

func _on_detection_area_body_entered(body: CharacterBody2D) -> void:
	direction.x = body.global_position.x - character.global_position.x
	direction = direction.normalized()
