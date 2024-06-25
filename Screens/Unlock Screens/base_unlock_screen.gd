extends CanvasLayer

@export var skill_name: String
@export var action_name: String
@export_multiline var skill_description: String
@export var screenshot: Texture2D

@onready var title_label: Label = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/TitleLabel
@onready var desc_label: Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer2/DescLabel
@onready var texture_rect: TextureRect = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer2/TextureRect

func _ready() -> void:
	title_label.text = skill_name.capitalize()
	desc_label.text = filter_string(skill_description, action_name)
	texture_rect.texture = screenshot

func filter_string(string: String, action_name: String) -> String:
	if string.contains("%key%"):
		string = string.replace("%key%", SettingsManager.INPUT_MAPPINGS[action_name].as_text().to_upper())
	
	string = string.replace("%left%", SettingsManager.INPUT_MAPPINGS["left"].as_text().to_upper())
	string = string.replace("%right%", SettingsManager.INPUT_MAPPINGS["right"].as_text().to_upper())
	
	if string.contains("LEFT MOUSE BUTTON"):
		string = string.replace("LEFT MOUSE BUTTON", "LMB")
	if string.contains("RIGHT MOUSE BUTTON"):
		string = string.replace("RIGHT MOUSE BUTTON", "RMB")
		
	return string

