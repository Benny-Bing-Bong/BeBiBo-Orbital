extends State

@export var shockwave_location: Node2D
@export var speed: float = 20

var direction: Vector2
var player_detected: bool = false

@onready var detection_area: Area2D = $"../../DetectionArea"
@onready var timer: Timer = $Timer # Period for player to attack

func enter() -> void:
	super()
	timer.start()

func state_physics_process(_delta: float) -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, speed)
	detect_player()
	move()
	character.move_and_slide()

func detect_player() -> void:
	detection_area.monitoring = false
	detection_area.monitoring = true

func update_facing_direction() -> void:
	if direction.x < 0:
		anim_sprite.flip_h = false
		shockwave_location.scale.x = 1
	else:
		anim_sprite.flip_h = true
		shockwave_location.scale.x = -1

func move() -> void:
	if timer.is_stopped() and player_detected:
		transitioned.emit(self, "move")

func _on_detection_area_body_entered(body: CharacterBody2D) -> void:
	direction = body.global_position - character.global_position
	direction = direction.normalized()
	update_facing_direction()
	player_detected = true
