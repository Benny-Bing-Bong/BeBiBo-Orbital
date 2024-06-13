class_name Shockwave
extends RigidBody2D

@export var animated_sprite_2d: AnimatedSprite2D
var shockwave_speed: int = 250

func _physics_process(delta: float) -> void:
	move_local_x(shockwave_speed * delta)

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()

func flip_shockwave() -> void:
	animated_sprite_2d.flip_h = true
	shockwave_speed = -shockwave_speed
