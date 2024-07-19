extends SFXManager

const BAD_END_SFX = preload("res://Audio/SFX/CutsceneSFX/bad_end_sfx.wav")
const GOOD_END_SFX = preload("res://Audio/SFX/CutsceneSFX/good_end_sfx.wav")
const PULSE_SFX = preload("res://Audio/SFX/CutsceneSFX/pulse_sfx.wav")

func pulse() -> void:
	play_sfx(PULSE_SFX, 0).play()

func good_end() -> void:
	play_sfx(GOOD_END_SFX, -5).play()

func bad_end() -> void:
	play_sfx(BAD_END_SFX, 0).play()
