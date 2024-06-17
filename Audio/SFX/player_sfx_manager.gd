extends AudioStreamPlayer

const JUMP = preload("res://Audio/SFX/Jump.wav")
const DASH = preload("res://Audio/SFX/Dash.wav")
const LASER_CHARGE = preload("res://Audio/SFX/Laser Charge.wav")
const LASER_FIRE = preload("res://Audio/SFX/Laser Fire.wav")
const PHASE_SHIFT = preload("res://Audio/SFX/Phase Shift.wav")
const DEATH_1 = preload("res://Audio/SFX/Death 1.wav")
const DEATH_2 = preload("res://Audio/SFX/Death 2.wav")

func play_sfx(audio_stream: AudioStream) -> AudioStreamPlayer:
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(player)
	player.finished.connect(player.queue_free)
	player.stream = audio_stream
	player.bus = "Sound_Effect"
	return player

func jump() -> void:
	play_sfx(JUMP).play()

func dash() -> void:
	play_sfx(DASH).play()

func phase_shift() -> void:
	play_sfx(PHASE_SHIFT).play()
	
func laser() -> void:
	var charging: AudioStreamPlayer = play_sfx(LASER_CHARGE)
	charging.play()
	await charging.finished
	play_sfx(LASER_FIRE).play()

func die() -> void:
	var dying: AudioStreamPlayer = play_sfx(DEATH_1)
	dying.play()
	await dying.finished
	play_sfx(DEATH_2).play()
