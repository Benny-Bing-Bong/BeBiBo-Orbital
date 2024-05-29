extends Area2D

@export var new_level_path: String

# because of collision mask, no need to explicitly check for player
func _on_body_entered(body: Node2D) -> void:
	SceneManager.transition_to_scene(new_level_path)
