extends Button

@export var skill_name: String
@export var sprite_icon: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = skill_name.capitalize()
	icon = sprite_icon

func _on_pressed() -> void:
	ScreenManager.add_layer_to_screen(skill_name)
