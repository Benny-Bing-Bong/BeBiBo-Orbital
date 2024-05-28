extends State

@onready var anim_duration_timer: Timer = $AnimDurationTimer

var speed: float = 200.0
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter() -> void:
	super()
	can_move = false
	anim_duration_timer.start()
	

func state_physics_process(delta: float) -> void:
	anim_sprite.flip_v = true
	character.velocity.x = move_toward(character.velocity.x, 0, speed * delta)
	character.velocity.y += gravity * delta
	
	character.move_and_slide()

func flash_times(times: int) -> void:
	for n in times:
		character.visible = false
		await get_tree().create_timer(0.2).timeout
		character.visible = true
		await get_tree().create_timer(0.2).timeout

func _on_anim_duration_timer_timeout() -> void:
	await flash_times(3)
	character.queue_free()
