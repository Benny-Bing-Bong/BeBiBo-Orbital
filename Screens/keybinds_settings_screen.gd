extends CanvasLayer

@export var input_button: PackedScene

@onready var action_list: VBoxContainer = %ActionList

var is_remapping: bool = false
var action_to_remap: StringName
var remapping_button: Button

var input_actions: Dictionary = {
	"unlocks": "unlocks",
	"close": "close",
	"left": "move left",
	"right": "move right",
	"interact": "interact",
	"attack": "attack",
	"up": "jump",
	"down": "crouch",
	"dash": "dash",
	"phaseshift": "phaseshift",
	"laser": "laser",
	"bomb": "bomb",
}

func _ready() -> void:
	create_action_list()

func create_action_list() -> void:
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action: String in input_actions:
		var button: Button = input_button.instantiate()
		var action_label: Label = button.find_child("ActionLabel")
		var input_label: Label = button.find_child("InputLabel")
		
		var action_name: String = input_actions[action]
		
		if not UnlockManager.contains(action_name):
			action_label.text = action_name.capitalize()
		else:
			if UnlockManager.able_to(action_name):
				action_label.text = action_name.capitalize()
			else:
				action_label.text = "??????"
				button.disabled = true
		
		var events: Array[InputEvent] = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text()
		else:
			input_label.text = "UNBINDED"
		
		action_list.add_child(button)
		button.pressed.connect(on_input_button_pressed.bind(button, action))

func on_input_button_pressed(button: Button, action: StringName) -> void:
	if not is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("InputLabel").text = "PRESS KEY TO BIND..."

func _input(event: InputEvent) -> void:
	if is_remapping:
		if event is InputEventMouseButton and event.double_click:
				event.double_click = false
				
		if (event is InputEventKey) or (event is InputEventMouseButton and event.is_pressed()):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			update_action_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = ""
			remapping_button = null

func update_action_list(button: Button, event: InputEvent) -> void:
	button.find_child("InputLabel").text = event.as_text()

func _on_reset_button_pressed() -> void:
	create_action_list()
