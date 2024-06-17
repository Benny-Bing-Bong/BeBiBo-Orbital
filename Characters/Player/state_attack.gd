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

# FOR AIR ATTACK SAVE HERE FIRST
#@export var attack_speed: int = 1500
#@onready var direction: Vector2
#@onready var gravity: Gravity = $"../../Gravity"
# in enter
	#gravity.disable()
	#character.velocity.y = 0
	
	#direction = character.get_facing_direction()
	#character.velocity.x = direction.x * attack_speed

# in state_input for moving forward while attacking
	#character.velocity.x = direction.x * attack_speed	

# in go_back_move
	#gravity.enable()
