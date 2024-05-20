extends State

@export var shockwave: PackedScene
@export var speed: float = 20.0

var direction: Vector2
# For shockwave instances
var wave_left: Node2D
var wave_right: Node2D

@onready var timer: Timer = $Timer # 2x of animation duration, so walk twice
@onready var timer_first_atk: Timer = $TimerFirstAtk
@onready var timer_second_atk: Timer = $TimerSecondAtk
@onready var timer_reset: Timer = $TimerReset
@onready var wave_spawn: Node2D = $"../../ShockwaveSpawnLocs"

func enter() -> void:
	super()
	direction = Vector2.RIGHT if anim_sprite.flip_h else Vector2.LEFT
	timer.start()
	timer_first_atk.start()
	timer_second_atk.start()
	timer_reset.start()

func state_physics_process(_delta: float) -> void:
	character.velocity.x = direction.x * speed
	character.move_and_slide()

func _on_timer_timeout() -> void:
	transitioned.emit(self, "idle")

func _on_timer_first_atk_timeout() -> void:
	instantiate_waves()
	put_at_position(0, 1)
	add_wave_to_scene()

func _on_timer_second_atk_timeout() -> void:
	instantiate_waves()
	put_at_position(2, 3)
	add_wave_to_scene()

func _on_timer_reset_timeout() -> void:
	timer_first_atk.start()
	timer_second_atk.start()

func instantiate_waves() -> void:
	wave_left = shockwave.instantiate()
	wave_right = shockwave.instantiate()
	wave_left.scale.x = -1

func put_at_position(first: int, second: int) -> void:
	if direction == Vector2.LEFT:
		wave_left.global_position = wave_spawn.get_child(first).global_position
		wave_right.global_position = wave_spawn.get_child(second).global_position
	elif direction == Vector2.RIGHT:
		wave_left.global_position = wave_spawn.get_child(second).global_position
		wave_right.global_position = wave_spawn.get_child(first).global_position

func add_wave_to_scene() -> void:
	character.get_parent().add_child(wave_left)
	character.get_parent().add_child(wave_right)
