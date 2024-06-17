extends AudioStreamPlayer

const STEPS = preload("res://Audio/SFX/Steps.wav")
const PICK_UP = preload("res://Audio/SFX/PickUp.wav")
const ATTACK = preload("res://Audio/SFX/Attack.mp3")
const JUMP = preload("res://Audio/SFX/Jump.wav")
const DASH = preload("res://Audio/SFX/Dash.wav")
const LASER_CHARGE = preload("res://Audio/SFX/Laser Charge.wav")
const LASER_FIRE = preload("res://Audio/SFX/Laser Fire.wav")
const PHASE_SHIFT = preload("res://Audio/SFX/Phase Shift.wav")
const THROW = preload("res://Audio/SFX/Throw.wav")
const BLAST = preload("res://Audio/SFX/Blast.wav")
const HURT = preload("res://Audio/SFX/Hurt.wav")
const DEATH_1 = preload("res://Audio/SFX/Death 1.wav")
const DEATH_2 = preload("res://Audio/SFX/Death 2.wav")

func play_sfx(audio_stream: AudioStream, volume: float) -> AudioStreamPlayer:
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(player)
	player.finished.connect(player.queue_free)
	player.stream = audio_stream
	player.volume_db = volume
	player.bus = "Player SFX"
	return player

func run() -> void:
	play_sfx(STEPS, -10).play()

func pick_up() -> void:
	play_sfx(PICK_UP, 0).play()

func attack() -> void:
	play_sfx(ATTACK, 0).play()

func jump() -> void:
	play_sfx(JUMP, 0).play()

func dash() -> void:
	play_sfx(DASH, 5).play()
	
func laser() -> void:
	var charging: AudioStreamPlayer = play_sfx(LASER_CHARGE, 0)
	charging.play()
	await charging.finished
	play_sfx(LASER_FIRE, 0).play()

func throw() -> void:
	play_sfx(THROW, -5).play()

func blast() -> void:
	play_sfx(BLAST, -5).play()

func phase_shift() -> void:
	play_sfx(PHASE_SHIFT, 0).play()

func hurt() -> void:
	play_sfx(HURT, -5).play()

func die() -> void:
	var dying: AudioStreamPlayer = play_sfx(DEATH_1, 0)
	dying.play()
	await dying.finished
	play_sfx(DEATH_2, 0).play()
