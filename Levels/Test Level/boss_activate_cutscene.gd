extends Cutscene

@export var boss: CharacterBody2D
@export var boss_sprite: AnimatedSprite2D

var activate_played: bool = false
var activate_playing: bool = false

func start_cutscene() -> void:
	super()
	GameMusic.play_boss_music()

func _physics_process(delta: float) -> void:
	if is_playing:
		player.velocity.x = 0
		
		if not activate_playing:
			path_follow_2d.progress_ratio += 0.002
		
		if path_follow_2d.progress_ratio >= 0.5 and not activate_played and not activate_playing:
			activate_playing = true
			boss_sprite.play("activate")
			await get_tree().create_timer(3).timeout
			
			activate_played = true
			activate_playing = false
			
		
		if path_follow_2d.progress_ratio >= 1:
			end_cutscene()
	else:
		return

func end_cutscene() -> void:
	super()
	for child in boss.get_children():
		if child is EnemyStateMachine:
			child.emit_signal("interrupt_state", "idle")


func _on_boss_damageable_activate() -> void:
	
	path_2d.curve.add_point(player.global_position)
	
	var final_point: Vector2 = boss.global_position
	final_point.y -= 60
	path_2d.curve.add_point(final_point)
	path_2d.curve.add_point(player.global_position)
	start_cutscene()
