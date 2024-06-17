extends State

@export var impulse: float = 400

# currently not pushing off yet
func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("up"):
		
		# Add bounce off wall impulse
		if character.get_wall_normal().x > 0:
			character.velocity.x += impulse
		elif character.get_wall_normal().x < 0:
			character.velocity.x -= impulse
		
		jump()

func state_physics_process(_delta: float) -> void:
	character.velocity.y = 0 # for slower falling
	
	var wall_direction: int = character.get_wall_normal().x
	
	# Player has to hold down the key to wallhang
	if ((wall_direction > 0 and not Input.is_action_pressed("left")) or 
		(wall_direction < 0 and not Input.is_action_pressed("right")) or
		(wall_direction == 0)):
		fall()

func fall() -> void:
	transitioned.emit(self, "falling")

func jump() -> void:
	if UnlockManager.able_to("jump"):
		transitioned.emit(self, "jump")
