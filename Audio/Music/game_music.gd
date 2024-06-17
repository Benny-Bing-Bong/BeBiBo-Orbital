extends AudioStreamPlayer

const game_music: AudioStreamMP3 = preload("res://Audio/Music/game_music.mp3")

func _play_music(music: AudioStreamMP3, volume: float = -20) -> void:
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func play_game_music() -> void:
	_play_music(game_music)
