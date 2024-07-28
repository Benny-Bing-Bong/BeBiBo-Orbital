extends Cutscene

@export var boss: CharacterBody2D
@export var boss_sprite: AnimatedSprite2D

var is_dead: bool = false
var is_dying: bool = false

func _physics_process(delta: float) -> void:
	if is_playing:
		player.velocity.x = 0
		
		if not is_dying:
			path_follow_2d.progress_ratio += 0.004
		
		if path_follow_2d.progress_ratio >= 0.5 and not is_dead and not is_dying:
			is_dying = true
			await get_tree().create_timer(2).timeout
			
			is_dead = true
			is_dying = false
			
		
		if path_follow_2d.progress_ratio >= 1:
			end_cutscene()
	else:
		return

func start_cutscene() -> void:
	boss.velocity.x = 0
	boss.is_agitated = false
	boss_sprite.speed_scale = 1
	GameMusic.stop_music()
	super()

func end_cutscene() -> void:
	super()
	await get_tree().create_timer(2).timeout
	MDM.force_dialogue("defeat_boss")

func _on_boss_damageable_die() -> void:
	path_2d.curve.add_point(player.global_position)
	var final_point: Vector2 = boss.global_position
	final_point.y = player.global_position.y
	path_2d.curve.add_point(final_point)
	path_2d.curve.add_point(player.global_position)
	start_cutscene()
