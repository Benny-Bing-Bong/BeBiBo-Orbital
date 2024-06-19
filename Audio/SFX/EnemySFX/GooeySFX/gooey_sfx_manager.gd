extends SFXManager

const CRAWL = preload("res://Audio/SFX/EnemySFX/GooeySFX/Crawl.wav")
const HURT = preload("res://Audio/SFX/EnemySFX/GooeySFX/Hurt.wav")
const DEATH = preload("res://Audio/SFX/EnemySFX/GooeySFX/Death.wav")

func crawl() -> void:
	play_sfx(CRAWL, 0).play()

func hurt() -> void:
	play_sfx(HURT, 0).play()

func die() -> void:
	var player: AudioStreamPlayer = play_sfx(DEATH, 0)
	player.play()
	await player.finished
	play_sfx(DEATH, 0).play()
