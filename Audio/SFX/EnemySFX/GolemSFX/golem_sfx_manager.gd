extends SFXManager

const IDLE = preload("res://Audio/SFX/EnemySFX/GolemSFX/Idle.wav")
const STOMP = preload("res://Audio/SFX/EnemySFX/GolemSFX/Stomp.wav")
const HURT = preload("res://Audio/SFX/EnemySFX/GolemSFX/Hurt.wav")
const BREAK_1 = preload("res://Audio/SFX/EnemySFX/GolemSFX/Break 1.wav")
const BREAK_2 = preload("res://Audio/SFX/EnemySFX/GolemSFX/Break 2.wav")
const SHUTDOWN = preload("res://Audio/SFX/EnemySFX/GolemSFX/Shutdown.wav")
const CRUMBLE_1 = preload("res://Audio/SFX/EnemySFX/GolemSFX/Crumble 1.wav")
const CRUMBLE_2 = preload("res://Audio/SFX/EnemySFX/GolemSFX/Crumble 2.wav")
const CRUMBLE_3 = preload("res://Audio/SFX/EnemySFX/GolemSFX/Crumble 3.wav")
const CRUMBLE_4 = preload("res://Audio/SFX/EnemySFX/GolemSFX/Crumble 4.wav")

func idle() -> void:
	play_sfx(IDLE, 0).play()

func stomp() -> void:
	play_sfx(STOMP, 0).play()

func hurt() -> void:
	play_sfx(HURT, 0).play()

func die() -> void:
	play_sfx(SHUTDOWN, 0).play()
	play_sfx(BREAK_1, 0).play()
	play_sfx(BREAK_2, 0).play()
	await get_tree().create_timer(1).timeout
	play_sfx(CRUMBLE_1, 0).play()
	play_sfx(CRUMBLE_2, 0).play()
	play_sfx(CRUMBLE_3, 0).play()
	play_sfx(CRUMBLE_4, 0).play()
	
