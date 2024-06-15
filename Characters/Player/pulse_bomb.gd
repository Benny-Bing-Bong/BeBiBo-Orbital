extends RigidBody2D

@export var blast: PackedScene

var bomb_speed: int = 200
var inverted: bool = false

func change_to_anti() -> void:
	inverted = true

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	explode()

func explode() -> void:
	var blast: Sprite2D = blast.instantiate()
	
	blast.global_position = global_position
	
	if inverted:
		blast.change_to_anti()
	
	get_parent().add_child(blast)
	queue_free()
