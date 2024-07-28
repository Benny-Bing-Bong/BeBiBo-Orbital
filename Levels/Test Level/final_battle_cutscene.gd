extends Cutscene

@export var boss_head: CharacterBody2D
@export var boss_head_sprite: AnimatedSprite2D

const ENEMY_COLLISION: int = 3
const ANTI_ENEMY_COLLISION: int = 6

var boss: CharacterBody2D
var is_warned: bool = false
var is_warning: bool = false

func _physics_process(delta: float) -> void:
	if is_playing:
		player.velocity.x = 0
		
		if not is_warning:
			path_follow_2d.progress_ratio += 0.004
		
		if path_follow_2d.progress_ratio >= 0.5 and not is_warned and not is_warning:
			is_warning = true
			await get_tree().create_timer(3).timeout
			
			is_warned = true
			is_warning = false
			
		
		if path_follow_2d.progress_ratio >= 1:
			end_cutscene()
	else:
		return

func start_cutscene() -> void:
	super()
	boss_head.velocity.x = 0
	for child in boss_head.get_children():
		if child is EnemyStateMachine:
			child.emit_signal("interrupt_state", "idle")
	boss_head_sprite.play("warning")

func end_cutscene() -> void:
	super()
	for child in boss_head.get_children():
		if child is EnemyStateMachine:
			child.emit_signal("interrupt_state", "warning")

func _on_boss_head_damageable_final_stage() -> void:
	
	path_2d.curve.add_point(player.global_position)
	path_2d.curve.add_point(boss_head.global_position)
	path_2d.curve.add_point(player.global_position)
	start_cutscene()
