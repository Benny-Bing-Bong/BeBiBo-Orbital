extends State

@onready var timer: Timer = $Timer

@export var knockback_speed: float = 4000.0
@onready var ray_cast_left: RayCast2D = $"../../RayCast_Left"
@onready var ray_cast_right: RayCast2D = $"../../RayCast_Right"

var direction: Vector2

func state_physics_process(delta: float) -> void:
	if ray_cast_left.is_colliding():
		anim_sprite.flip_h = false
	
	if ray_cast_right.is_colliding():
		anim_sprite.flip_h = true
		
	direction = Vector2.RIGHT if anim_sprite.flip_h else Vector2.LEFT
	
	character.velocity.x = -direction.x * knockback_speed * delta
		
	if timer.is_stopped():
		timer.start()
	
	character.move_and_slide()

func crawl() -> void:
	transitioned.emit(self, "crawl")

func _on_timer_timeout() -> void:
	character.velocity = Vector2.ZERO
	crawl() # Replace with function body.
