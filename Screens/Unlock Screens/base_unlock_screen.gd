extends CanvasLayer

@export var skill_name: String
@export_multiline var skill_description: String
@export var screenshot: Texture2D

@onready var title_label: Label = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/TitleLabel
@onready var desc_label: Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer2/DescLabel
@onready var texture_rect: TextureRect = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer2/TextureRect

func _ready() -> void:
	title_label.text = skill_name.capitalize()
	desc_label.text = skill_description
	texture_rect.texture = screenshot
