extends State

@onready var timer: Timer = $Timer
@onready var ray_cast_left: RayCast2D = $"../../RayCast_Left"
@onready var ray_cast_right: RayCast2D = $"../../RayCast_Right"

var timer_active: bool = false
var speed: float = 200.0
var detectable_dist: float = 100.0
var curr_position: Vector2
var direction: Vector2


func state_physics_process(delta: float) -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, speed * delta)
	direction = Vector2.RIGHT if anim_sprite.flip_h else Vector2.LEFT
	
	curr_position = character.get_position_delta()
	
	if not timer_active:
		timer.start()
		timer_active = true
	
	anim_sprite.flip_h = direction.x > 0
	detect_player()
	character.move_and_slide()

func crawl() -> void:
	transitioned.emit(self, "crawl")

func detect_player() -> void:
	if not timer.is_stopped():
		return
		
	if ray_cast_left.is_colliding():
		if direction == Vector2.LEFT:
			crawl()
		else:
			anim_sprite.flip_h = false
			timer.start()
	elif ray_cast_right.is_colliding():
		if direction == Vector2.RIGHT:
			crawl()
		else:
			anim_sprite.flip_h = true
			timer.start()
