extends Cutscene

@export var boss_detection: Area2D

var boss: CharacterBody2D

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_playing:
		player.velocity.x = 0
		path_follow_2d.progress_ratio += 0.002
		
		if path_follow_2d.progress_ratio >= 1:
			end_cutscene()
	else:
		return

func _on_boss_detection_body_entered(body: CharacterBody2D) -> void:
	boss = body
	
	path_2d.curve.add_point(player_camera.global_position)
	path_2d.curve.add_point(boss.global_position)
