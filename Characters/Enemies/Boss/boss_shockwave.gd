class_name BossShockwave
extends RigidBody2D

@export var animated_sprite_2d: AnimatedSprite2D
var shockwave_speed: int = 500

func _physics_process(delta: float) -> void:
	linear_velocity.x = shockwave_speed

func flip_shockwave() -> void:
	animated_sprite_2d.flip_h = true
	shockwave_speed = -shockwave_speed

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
