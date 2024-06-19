extends Area2D

@export var new_level_name: String

func _ready() -> void:
	monitoring = false
	SceneManager.enemies_cleared.connect(on_enemies_cleared)

# because of collision mask, no need to explicitly check for player
func _on_body_entered(body: Node2D) -> void:
	SceneManager.transition_to_scene(new_level_name)

func on_enemies_cleared() -> void:
	monitoring = true
