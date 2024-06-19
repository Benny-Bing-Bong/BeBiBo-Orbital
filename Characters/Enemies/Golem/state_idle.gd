extends State

@export var ray_cast_left: RayCast2D
@export var ray_cast_right: RayCast2D
@export var shockwave_location: Node2D
@export var speed: float = 20

var direction: Vector2

@onready var timer: Timer = $Timer # Period for player to attack
@onready var sound_timer: Timer = $SoundTimer

func enter() -> void:
	super()
	timer.start()

func state_physics_process(_delta: float) -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, speed)
	detect_player()
	update_facing_direction()
	move()
	character.move_and_slide()

func detect_player() -> void:
	if ray_cast_left.is_colliding():
		direction = Vector2.LEFT
	elif ray_cast_right.is_colliding():
		direction = Vector2.RIGHT

func update_facing_direction() -> void:
	if direction == Vector2.LEFT:
		anim_sprite.flip_h = false
		shockwave_location.scale.x = 1
	elif direction == Vector2.RIGHT:
		anim_sprite.flip_h = true
		shockwave_location.scale.x = -1

func move() -> void:
	if sound_timer.is_stopped():
		GolemSFX.idle()
		sound_timer.start()
	if ((ray_cast_left.is_colliding() or ray_cast_right.is_colliding())
		and timer.is_stopped()):
		transitioned.emit(self, "move")
