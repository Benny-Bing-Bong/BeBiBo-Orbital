extends State

@onready var timer: Timer = $Timer

func enter() -> void:
	super()
	timer.start()
	
	PlayerSFX.attack()

func _on_timer_timeout() -> void:
	go_back_move()

func go_back_move() -> void:
	transitioned.emit(self, "ground")
