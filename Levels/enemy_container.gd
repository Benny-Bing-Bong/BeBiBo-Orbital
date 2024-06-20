class_name EnemyContainer
extends Node

func _process(delta: float) -> void:
	SceneManager.update_enemies_left(get_children().size())
	
	if get_children().is_empty():
		queue_free()
