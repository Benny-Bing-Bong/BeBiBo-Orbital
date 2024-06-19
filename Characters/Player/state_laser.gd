extends State

@export var laser_scene: PackedScene

func enter() -> void:
	super()
	character.velocity.x = 0 # stop all movement
	
	PlayerSFX.laser()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == first_anim_name:
		spawn_laser()
		go_back_move()

func go_back_move() -> void:
	transitioned.emit(self, "ground")

func spawn_laser() -> void:
	var laser: Sprite2D = laser_scene.instantiate()
	
	# set laser's position to be correct according to player
	laser.global_position.y = character.global_position.y - 14
	laser.global_position.x = character.global_position.x + 24
	if character.sprite.flip_h:
		laser.global_position.x = character.global_position.x - 24
		laser.scale.x = -1
	
	# set correct collision masks in case player in in anti phase
	if PlayerManager.is_anti():
		laser.change_to_anti()
	
	# spawn the laser
	character.get_parent().add_child(laser)
