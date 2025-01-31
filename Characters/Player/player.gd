class_name Player
extends CharacterBody2D

@export var accel: float = 200.0
@export var max_speed: float = 200.0

var direction: Vector2 = Vector2.ZERO
var can_move: bool = true

const PLAYER_COLLISION: int = 2
const ENEMY_COLLISION: int = 3
const ANTI_PLAYER: int = 5
const ANTI_ENEMY: int = 6
const DEFAULT_PLATFORM: int = 9
const ANTI_PLATFORM: int = 10

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var hitbox: Hitbox = $Hitbox
@onready var hitbox_2: Hitbox = $Hitbox2

func _ready() -> void:
	animation_tree.active = true
	
	if PlayerManager.is_anti():
		RenderingServer.global_shader_parameter_set("inverted", true)
		swap_layers_and_masks()

func _input(event: InputEvent) -> void:
	if not can_move:
		return
		
	if (event.is_action_pressed("phaseshift") and UnlockManager.able_to("phaseshift")
	and CooldownManager.skill_ready("phaseshift")):
		phase_shift()

func _physics_process(delta: float) -> void:
	if player_state_machine.get_can_move() and can_move:
		direction = Input.get_vector("left", "right", "up", "down")
		if direction.x != 0:
			velocity.x = move_toward(velocity.x, direction.x * max_speed, accel)
		else:
			velocity.x = move_toward(velocity.x, 0, accel)
	
	# currently called in gravity
	#move_and_slide()
	if GameManager.player_alive:
		update_animation_parameters()
		update_facing_direction()

func update_animation_parameters() -> void:
		animation_tree.set("parameters/move/blend_position", direction.x)
		animation_tree.set("parameters/crouch/blend_position", direction.x)

func update_facing_direction() -> void:
	var slash1_hitbox: CollisionShape2D = $Hitbox/Slash1ColShape2D
	var slash2_hitbox: CollisionShape2D = $Hitbox2/Slash2ColShape2D
	var air1_hitbox: CollisionShape2D = $Hitbox/Air1ColShape2D
	var air2_hitbox: CollisionShape2D = $Hitbox2/Air2ColShape2D
	
	var distance1: float = abs(
			slash1_hitbox.global_position.x - 
			global_position.x)
	var distance2: float = abs(
			slash2_hitbox.global_position.x - 
			global_position.x)
	var distance3: float = abs(
			air1_hitbox.global_position.x - 
			global_position.x)
	var distance4: float = abs(
			air2_hitbox.global_position.x - 
			global_position.x)
	
	if direction.x > 0:
		sprite.flip_h = false
		slash1_hitbox.position.x = distance1
		slash2_hitbox.position.x = distance2
		air1_hitbox.position.x = distance3
		air2_hitbox.position.x = distance4
	elif direction.x < 0:
		sprite.flip_h = true
		slash1_hitbox.position.x = -distance1
		slash2_hitbox.position.x = -distance2
		air1_hitbox.position.x = -distance3
		air2_hitbox.position.x = -distance4

func get_facing_direction() -> Vector2:
	if sprite.flip_h == false:
		return Vector2.RIGHT
	else:
		return Vector2.LEFT

func phase_shift() -> void:
	# sprite inversion
	RenderingServer.global_shader_parameter_set("inverted", 
			not PlayerManager.is_anti())
	
	# play animation and start cooldown timer
	sprite.phase_animation()
	CooldownManager.start_cooldown("phaseshift")
	PlayerSFX.phase_shift()
	
	# buffer to ensure phase change is complete before setting collision values
	await get_tree().create_timer(0.25).timeout
	
	swap_layers_and_masks()
	
	PlayerManager.phase_shift()

func swap_layers_and_masks() -> void:
	# set default or anti platform mask
	set_collision_mask_value(DEFAULT_PLATFORM,
			not get_collision_mask_value(DEFAULT_PLATFORM))
	set_collision_mask_value(ANTI_PLATFORM,
			not get_collision_mask_value(ANTI_PLATFORM))
	
	# set new phase's collision layers and masks
	set_collision_layer_value(PLAYER_COLLISION, 
			not get_collision_layer_value(PLAYER_COLLISION))
	set_collision_layer_value(ANTI_PLAYER, 
			not get_collision_layer_value(ANTI_PLAYER))
	
	# stop processing if hitbox doesn't exist
	if not hitbox:
		return
	
	hitbox.set_collision_layer_value(PLAYER_COLLISION, 
			not hitbox.get_collision_layer_value(PLAYER_COLLISION))
	hitbox.set_collision_layer_value(ANTI_PLAYER, 
			not hitbox.get_collision_layer_value(ANTI_PLAYER))
	hitbox.set_collision_mask_value(ENEMY_COLLISION, 
			not hitbox.get_collision_mask_value(ENEMY_COLLISION))
	hitbox.set_collision_mask_value(ANTI_ENEMY, 
			not hitbox.get_collision_mask_value(ANTI_ENEMY))
	
	hitbox_2.set_collision_layer_value(PLAYER_COLLISION, 
			not hitbox_2.get_collision_layer_value(PLAYER_COLLISION))
	hitbox_2.set_collision_layer_value(ANTI_PLAYER, 
			not hitbox_2.get_collision_layer_value(ANTI_PLAYER))
	hitbox_2.set_collision_mask_value(ENEMY_COLLISION, 
			not hitbox_2.get_collision_mask_value(ENEMY_COLLISION))
	hitbox_2.set_collision_mask_value(ANTI_ENEMY, 
			not hitbox_2.get_collision_mask_value(ANTI_ENEMY))

func stop_player() -> void:
	can_move = false
	velocity.x = move_toward(velocity.x, 0, accel)
	player_state_machine.emit_signal("interrupted_state", "ground")
	
func enable_movement() -> void:
	can_move = true
