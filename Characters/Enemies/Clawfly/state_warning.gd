extends State

@onready var timer: Timer = $Timer
@onready var sound_timer: Timer = $SoundTimer

func enter() -> void:
	super()
	timer.start()

func state_physics_process(delta: float) -> void:
	if sound_timer.is_stopped():
		ClawflySFX.buzz()
		sound_timer.start()

func _on_timer_timeout() -> void:
	attack()

func attack() -> void:
	transitioned.emit(self, "attack")
