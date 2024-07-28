extends Cutscene

@export var boss_sprite: AnimatedSprite2D
@export var move_state: State
@export var boss: CharacterBody2D

var agitated_played: bool = false
var agitated_playing: bool = false

func _physics_process(delta: float) -> void:
	if is_playing:
		player.velocity.x = 0
		
		if not agitated_playing:
			path_follow_2d.progress_ratio += 0.004
		
		if path_follow_2d.progress_ratio >= 0.5 and not agitated_played and not agitated_playing:
			agitated_playing = true
			await get_tree().create_timer(1).timeout
			boss.is_agitated = true
			boss.phase_shift()
			await get_tree().create_timer(1).timeout
			
			agitated_played = true
			agitated_playing = false
			
		
		if path_follow_2d.progress_ratio >= 1:
			end_cutscene()
	else:
		return

func start_cutscene() -> void:
	super()
	boss.velocity.x = 0
	for child in boss.get_children():
		if child is EnemyStateMachine:
			child.emit_signal("interrupt_state", "deactivated")
	boss_sprite.play("agitated")

func end_cutscene() -> void:
	super()
	for child in boss.get_children():
		if child is EnemyStateMachine:
			child.emit_signal("interrupt_state", "idle")
			
	move_state.agitated = true

func _on_boss_damageable_agitate() -> void:
	path_2d.curve.add_point(player.global_position)
	
	var final_point: Vector2 = boss.global_position
	final_point.y -= 60
	path_2d.curve.add_point(final_point)
	path_2d.curve.add_point(player.global_position)
	start_cutscene()
