class_name EnemyContainer
extends Node

func _process(delta: float) -> void:
	if get_children().is_empty():
		SceneManager.all_enemies_died()
		queue_free()
