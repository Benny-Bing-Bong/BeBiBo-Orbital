extends CharacterBody2D

var is_agitated: bool = false
var is_anti: bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var left_hurtbox: Hurtbox = $LeftHurtbox
@onready var right_hurtbox: Hurtbox = $RightHurtbox
@onready var phaseshift_timer: Timer = $PhaseshiftTimer

const PLAYER_COLLISION: int = 2
const ENEMY_COLLISION: int = 3
const ANTI_PLAYER: int = 5
const ANTI_ENEMY: int = 6

func _physics_process(delta: float) -> void:
	if not is_agitated or not phaseshift_timer.is_stopped():
		return
		
	phaseshift_timer.start()

func phase_shift() -> void:
	# sprite inversion
	RenderingServer.global_shader_parameter_set("boss_inverted", 
			not is_anti)
	
	# play animation and start cooldown timer
	animated_sprite_2d.phase_animation()
	PlayerSFX.phase_shift()
	
	# buffer to ensure phase change is complete before setting collision values
	await get_tree().create_timer(0.5).timeout
	
	swap_layers_and_masks()
	
	is_anti = not is_anti

func swap_layers_and_masks() -> void:
	if not is_agitated:
		return
	
	left_hurtbox.set_collision_layer_value(ENEMY_COLLISION, not left_hurtbox.get_collision_layer_value(ENEMY_COLLISION))
	left_hurtbox.set_collision_layer_value(ANTI_ENEMY, not left_hurtbox.get_collision_layer_value(ANTI_ENEMY))
	left_hurtbox.set_collision_mask_value(PLAYER_COLLISION, not left_hurtbox.get_collision_mask_value(PLAYER_COLLISION))
	left_hurtbox.set_collision_mask_value(ANTI_PLAYER, not left_hurtbox.get_collision_mask_value(ANTI_PLAYER))
	
	right_hurtbox.set_collision_layer_value(ENEMY_COLLISION, not right_hurtbox.get_collision_layer_value(ENEMY_COLLISION))
	right_hurtbox.set_collision_layer_value(ANTI_ENEMY, not right_hurtbox.get_collision_layer_value(ANTI_ENEMY))
	right_hurtbox.set_collision_mask_value(PLAYER_COLLISION, not right_hurtbox.get_collision_mask_value(PLAYER_COLLISION))
	right_hurtbox.set_collision_mask_value(ANTI_PLAYER, not right_hurtbox.get_collision_mask_value(ANTI_PLAYER))


func _on_phaseshift_timer_timeout() -> void:
	if not is_agitated:
		return
	phase_shift()
