extends State

@onready var timer: Timer = $Timer

var speed: float = 200.0

func state_physics_process(delta: float) -> void:
	if timer.is_stopped():
		timer.start()

func attack() -> void:
	transitioned.emit(self, "attack")

func _on_timer_timeout() -> void:
	attack()
