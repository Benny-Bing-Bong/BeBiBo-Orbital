extends State

@onready var ray_cast_left: RayCast2D = $"../../RayCast_Left"
@onready var ray_cast_right: RayCast2D = $"../../RayCast_Right"
@onready var timer: Timer = $Timer

var timer_active: bool = false
var speed: float = 2000.0
var curr_position: Vector2
var direction: Vector2

func state_physics_process(delta: float) -> void:
	curr_position = character.get_position_delta()
	direction = Vector2.RIGHT if anim_sprite.flip_h else Vector2.LEFT
		
	character.velocity.x = direction.x * speed * delta
	
	if direction == Vector2.LEFT and not ray_cast_left.is_colliding():
		if timer.is_stopped():
			timer.start()
	if direction == Vector2.RIGHT and not ray_cast_right.is_colliding():
		if timer.is_stopped():
			timer.start()
		
	character.move_and_slide()
	
func idle() -> void:
	transitioned.emit(self, "idle")

func _on_timer_timeout() -> void:
	if not ray_cast_left.is_colliding() and direction == Vector2.LEFT:
		idle() # Replace with function body.
	if not ray_cast_right.is_colliding() and direction == Vector2.RIGHT:
		idle()
