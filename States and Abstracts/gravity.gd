class_name Gravity
extends Node

@export var character_body : CharacterBody2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta : float) -> void:
	if not character_body.is_on_floor():
		character_body.velocity.y += gravity * delta
	
	character_body.move_and_slide()
