extends PanelContainer

@onready var tutorial_label: Label = $MarginContainer/VBoxContainer/TutorialLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UnlockManager.connect("tutorial_triggered", on_tutorial_triggered)
	visible = false

func on_tutorial_triggered(tutorial_string: String) -> void:
	tutorial_label.text = tutorial_string
	visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("close"):
		visible = false
