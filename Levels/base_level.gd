extends Node2D

func _ready() -> void:
	GameMusic.play_game_music()
	
	# Try to play the first ever dialogue on every scene load
	await get_tree().create_timer(1).timeout
	MDM.try_dialogue("new_game")
