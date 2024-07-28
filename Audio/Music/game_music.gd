extends AudioStreamPlayer

const GAME_MUSIC: AudioStreamMP3 = preload("res://Audio/Music/game_music.mp3")
const MENU_MUSIC: AudioStreamMP3 = preload("res://Audio/Music/main_menu_music.mp3")
const BAD_END_MUSIC = preload("res://Audio/Music/bad_end_music.mp3")
const GOOD_END_MUSIC = preload("res://Audio/Music/good_end_music.mp3")

func _play_music(music: AudioStreamMP3, volume: float = -10) -> void:
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func play_game_music() -> void:
	_play_music(GAME_MUSIC)

func play_menu_music() -> void:
	_play_music(MENU_MUSIC)

func play_bad_end_music() -> void:
	_play_music(BAD_END_MUSIC, 0)

func play_good_end_music() -> void:
	_play_music(GOOD_END_MUSIC, 0)

func stop_music() -> void:
	stop()
