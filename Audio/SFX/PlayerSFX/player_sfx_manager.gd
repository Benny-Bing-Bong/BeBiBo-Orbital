extends SFXManager

const STEPS = preload("res://Audio/SFX/PlayerSFX/Steps.wav")
const PICK_UP = preload("res://Audio/SFX/PlayerSFX/PickUp.wav")
const ATTACK = preload("res://Audio/SFX/PlayerSFX/Attack.mp3")
const JUMP = preload("res://Audio/SFX/PlayerSFX/Jump.wav")
const DASH = preload("res://Audio/SFX/PlayerSFX/Dash.wav")
const LASER_CHARGE = preload("res://Audio/SFX/PlayerSFX/Laser Charge.wav")
const LASER_FIRE = preload("res://Audio/SFX/PlayerSFX/Laser Fire.wav")
const PHASE_SHIFT = preload("res://Audio/SFX/PlayerSFX/Phase Shift.wav")
const THROW = preload("res://Audio/SFX/PlayerSFX/Throw.wav")
const BLAST = preload("res://Audio/SFX/PlayerSFX/Blast.wav")
const HURT = preload("res://Audio/SFX/PlayerSFX/Hurt.wav")
const DEATH_1 = preload("res://Audio/SFX/PlayerSFX/Death 1.wav")
const DEATH_2 = preload("res://Audio/SFX/PlayerSFX/Death 2.wav")

func run() -> void:
	play_sfx(STEPS, -5).play()

func pick_up() -> void:
	play_sfx(PICK_UP, -5).play()

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
	play_sfx(THROW, 0).play()

func blast() -> void:
	play_sfx(BLAST, 0).play()

func phase_shift() -> void:
	play_sfx(PHASE_SHIFT, 0).play()

func hurt() -> void:
	play_sfx(HURT, -5).play()

func die() -> void:
	var dying: AudioStreamPlayer = play_sfx(DEATH_1, -5)
	dying.play()
	await dying.finished
	play_sfx(DEATH_2, 5).play()
