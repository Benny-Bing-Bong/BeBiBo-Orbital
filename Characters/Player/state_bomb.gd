extends State

@export var bomb_scene: PackedScene
var bomb_speed: int = 500

func state_physics_process(delta: float) -> void:
	character.velocity.x = 0

func state_input(_input: InputEvent) -> void:
	if _input.is_action_pressed("fire"):
		throw()
	if _input.is_action_pressed("left") or _input.is_action_pressed("right"):
		go_back_move()
	if _input.is_action_pressed("up"):
		jump()
	if _input.is_action_pressed("attack"):
		attack()
	if _input.is_action_pressed("down"):
		crouch()
	if _input.is_action_pressed("dash"):
		dash()
	if _input.is_action_pressed("laser"):
		laser()

func throw() -> void:
	var bomb: RigidBody2D = bomb_scene.instantiate()
	var mouse_position: Vector2 = character.get_global_mouse_position()
	
	bomb.global_position.y = character.global_position.y
	bomb.global_position.x = character.global_position.x
	
	if character.inverted:
		bomb.change_to_anti()
	
	character.get_parent().add_child(bomb)
	transitioned.emit(self, "ground")
	
func jump() -> void:
	if UnlockManager.able_to("jump"):
		transitioned.emit(self, "air")

func attack() -> void:
	transitioned.emit(self, "attack")

func crouch() -> void:
	if UnlockManager.able_to("crouch"):
		transitioned.emit(self, "crouch")

func dash() -> void:
	if UnlockManager.able_to("dash") and StaminaManager.has_charge():
		StaminaManager.use_charge()
		transitioned.emit(self, "dash")

func laser() -> void:
	if UnlockManager.able_to("laser") and CooldownManager.skill_ready("laser"):
		CooldownManager.start_cooldown("laser")
		transitioned.emit(self, "laser")

func go_back_move() -> void:
	transitioned.emit(self, "ground")
