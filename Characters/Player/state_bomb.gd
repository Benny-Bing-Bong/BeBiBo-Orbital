extends State

@export var bomb_scene: PackedScene

func enter() -> void:
	super()
	throw()

func throw() -> void:
	var bomb: RigidBody2D = bomb_scene.instantiate()
	var mouse_position: Vector2 = character.get_global_mouse_position()
	
	bomb.global_position.y = character.global_position.y
	bomb.global_position.x = character.global_position.x
	
	if character.sprite.flip_h:
		bomb.linear_velocity.x *= -1
	
	character.get_parent().add_child(bomb)
	go_back_move()

func go_back_move() -> void:
	transitioned.emit(self, "ground")
