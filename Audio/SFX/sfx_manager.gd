class_name SFXManager
extends Node

func play_sfx(audio_stream: AudioStream, volume: float) -> AudioStreamPlayer:
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(player)
	player.finished.connect(player.queue_free)
	player.stream = audio_stream
	player.volume_db = volume
	player.bus = "Player SFX"
	return player
