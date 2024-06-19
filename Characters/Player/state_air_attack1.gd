extends State

@export var up_impulse: float = 300.0

@onready var timer: Timer = $Timer
@onready var dbl_air_timer: Timer = $DblAirTimer

func enter() -> void:
	super()
	PlayerManager.air1ed = true
	
	timer.start()
	character.velocity.y = -up_impulse
	
	PlayerSFX.attack()

func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("attack"):
		dbl_air_timer.start()

func _on_timer_timeout() -> void:
	if dbl_air_timer.is_stopped():
		fall()
	else:
		double_air()

func fall() -> void:
	transitioned.emit(self, "falling")

func double_air() -> void:
	transitioned.emit(self, "airattack2")
