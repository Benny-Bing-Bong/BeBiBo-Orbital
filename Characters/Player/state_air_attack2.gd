extends State

@export var front_impulse: float = 300.0

@onready var timer: Timer = $Timer
@onready var gravity: Gravity = $"../../Gravity"

func enter() -> void:
	super()
	PlayerManager.air2ed = true
	
	timer.start()
	
	gravity.disable()
	character.velocity.y = 0

func exit() -> void:
	gravity.enable()
	character.velocity.x = 0

func state_physics_process(_delta: float) -> void:
	var direction: Vector2 = character.get_facing_direction()
	character.velocity.x = direction.x * front_impulse

func _on_timer_timeout() -> void:
	fall()

func fall() -> void:
	transitioned.emit(self, "falling")
