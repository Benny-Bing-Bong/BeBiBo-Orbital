extends Cutscene

func _physics_process(delta: float) -> void:
	if is_playing:
		player.velocity.x = 0
		path_follow_2d.progress_ratio += 0.002
		
		if path_follow_2d.progress_ratio >= 1:
			end_cutscene()
	else:
		return


func _on_player_enter_detection_body_entered(body: CharacterBody2D) -> void:
	var final_point: Vector2 = player_camera.position
	path_2d.curve.add_point(final_point)
	
	if not played_cutscene:
		start_cutscene()
