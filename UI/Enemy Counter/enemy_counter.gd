extends Control

@onready var label: Label = $PanelContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneManager.enemies_changed.connect(on_enemies_changed)

func on_enemies_changed(number: int) -> void:
	if number == 0:
		label.text = "All enemies cleared!"
		return
	
	label.text = "%d enemies left" % number
