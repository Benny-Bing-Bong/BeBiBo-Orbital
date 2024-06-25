extends PanelContainer

@onready var tutorial_label: Label = $MarginContainer/VBoxContainer/TutorialLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UnlockManager.connect("tutorial_triggered", on_tutorial_triggered)
	visible = false

func on_tutorial_triggered(action_name: String, tutorial_string: String) -> void:
	tutorial_label.text = filter_string(tutorial_string, action_name)
	visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("close"):
		visible = false

func filter_string(string: String, action_name: String) -> String:
	if string.contains("%key%"):
		string = string.replace("%key%", SettingsManager.INPUT_MAPPINGS[action_name].as_text().to_upper())
	
	string = string.replace("%left%", SettingsManager.INPUT_MAPPINGS["left"].as_text().to_upper())
	string = string.replace("%right%", SettingsManager.INPUT_MAPPINGS["right"].as_text().to_upper())
	
	if string.contains("LEFT MOUSE BUTTON"):
		string = string.replace("LEFT MOUSE BUTTON", "LMB")
	if string.contains("RIGHT MOUSE BUTTON"):
		string = string.replace("RIGHT MOUSE BUTTON", "RMB")
		
	string = string.replace("%ul%", SettingsManager.INPUT_MAPPINGS["unlocks"].as_text().to_upper())
	return string
