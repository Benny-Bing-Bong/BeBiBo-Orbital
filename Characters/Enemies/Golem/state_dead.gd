extends State

@export var speed: float = 20.0

@onready var anim_duration_timer: Timer = $AnimDurationTimer

func enter() -> void:
	super()
	anim_duration_timer.start()

func state_physics_process(_delta: float) -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, speed)
	character.move_and_slide()

func _on_anim_duration_timer_timeout() -> void:
	await flash_times(3)
	character.queue_free()

func flash_times(times: int) -> void:
	for n in times:
		character.visible = false
		await get_tree().create_timer(0.2).timeout
		character.visible = true
		await get_tree().create_timer(0.2).timeout
