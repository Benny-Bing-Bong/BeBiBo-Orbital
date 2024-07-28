extends State

@export var speed: float = 20.0

@onready var timer: Timer = $Timer

func enter() -> void:
	super()
	timer.start()
	GolemSFX.die()

func state_physics_process(_delta: float) -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, speed)
	character.move_and_slide()

func flash_times(times: int) -> void:
	for n in times:
		character.visible = false
		await get_tree().create_timer(0.2).timeout
		character.visible = true
		await get_tree().create_timer(0.2).timeout


func _on_timer_timeout() -> void:
	await flash_times(3)
	character.queue_free()
