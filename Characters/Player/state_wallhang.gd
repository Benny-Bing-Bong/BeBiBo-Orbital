extends State

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# currently not pushing off yet
func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("up"):
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
