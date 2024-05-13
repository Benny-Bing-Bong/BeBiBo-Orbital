extends Node
class_name Gravity

@export var character_body : CharacterBody2D
@export var sprite : AnimatedSprite2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta : float) -> void:
	if !character_body.is_on_floor():
		character_body.velocity.y += gravity * delta
		
	character_body.move_and_slide()

