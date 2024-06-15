extends State

@onready var timer: Timer = $Timer

func enter() -> void:
	super()
	timer.start()

func _on_timer_timeout() -> void:
	attack()

func attack() -> void:
	transitioned.emit(self, "attack")
