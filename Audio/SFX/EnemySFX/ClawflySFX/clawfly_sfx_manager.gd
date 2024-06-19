extends SFXManager

const BUZZ = preload("res://Audio/SFX/EnemySFX/ClawflySFX/Buzz.wav")
const DEATH = preload("res://Audio/SFX/EnemySFX/ClawflySFX/Death.wav")

func buzz() -> void:
	play_sfx(BUZZ, 5).play()

func die() -> void:
	play_sfx(DEATH, 0).play()
