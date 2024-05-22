extends State

@export var shockwave: PackedScene
@export var speed: float = 20.0

var direction: Vector2
# For shockwave instances
var wave_left: Node2D
var wave_right: Node2D

@onready var wave_spawn: Node2D = $"../../ShockwaveSpawnLocs"
@onready var move_animation_player: AnimationPlayer = $MoveAnimationPlayer

func enter() -> void:
	super()
	direction = Vector2.RIGHT if anim_sprite.flip_h else Vector2.LEFT
	move_animation_player.play("summon_shockwaves")

func exit() -> void:
	move_animation_player.stop()

func state_physics_process(_delta: float) -> void:
	character.velocity.x = direction.x * speed
	character.move_and_slide()

#called in MoveAnimationPlayer under summon_shockwaves
func step_one() -> void:
	instantiate_waves()
	put_at_position(0, 1)
	add_wave_to_scene()

#called in MoveAnimationPlayer under summon_shockwaves
func step_two() -> void:
	instantiate_waves()
	put_at_position(2, 3)
	add_wave_to_scene()

#called in MoveAnimationPlayer under summon_shockwaves
func go_back_idle() -> void:
	transitioned.emit(self, "idle")

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
