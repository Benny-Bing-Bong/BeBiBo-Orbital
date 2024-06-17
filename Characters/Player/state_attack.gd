extends State

@onready var timer: Timer = $Timer
@onready var dbl_atk_timer: Timer = $DblAtkTimer

func enter() -> void:
	super()
	timer.start()

func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("attack"):
		dbl_atk_timer.start()

func _on_timer_timeout() -> void:
	if dbl_atk_timer.is_stopped():
		go_back_move()
	else:
		double_attack()

func double_attack() -> void:
	transitioned.emit(self, "attack2")

func go_back_move() -> void:
	transitioned.emit(self, "ground")
