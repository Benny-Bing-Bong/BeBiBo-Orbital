extends State

@export var dash_speed: float = 400.0
@export var ghost: PackedScene

@onready var dash_duration: Timer = $DashDuration
@onready var ghost_timer: Timer = $GhostTimer
@onready var hurtbox: Hurtbox = $"../../Hurtbox"

func enter() -> void:
	super()
	dash_duration.start()
	ghost_timer.start()
	hurtbox.monitoring = false

func state_physics_process(_delta: float) -> void:
	var direction: Vector2 = character.get_facing_direction()
	character.velocity.x = direction.x * dash_speed

func dash_effect() -> void:
	# instantiate dash ghost scene for dash effect
	var ghost: Node = ghost.instantiate()
	ghost.global_position = character.global_position
	ghost.texture = character.sprite.texture
	ghost.vframes = character.sprite.vframes
	ghost.hframes = character.sprite.hframes
	ghost.frame = character.sprite.frame
	ghost.flip_h = character.sprite.flip_h
	ghost.material.shader = character.sprite.material.shader
	
	get_tree().current_scene.add_child(ghost)

func go_back_move() -> void:
	transitioned.emit(self, "ground")

func _on_dash_duration_timeout() -> void:
	ghost_timer.stop()
	hurtbox.monitoring = true
	go_back_move()

func _on_ghost_timer_timeout() -> void:
	dash_effect()
