extends CanvasLayer

@export var input_button: PackedScene

@onready var action_list: VBoxContainer = %ActionList

var is_remapping: bool = false
var action_to_remap: StringName
var remapping_button: Button

# names for actions
var input_actions: Dictionary = {
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
	"unlocks": "unlocks",
	"close": "close",
}

func _ready() -> void:
	create_action_list()

func create_action_list() -> void:
	# remove all buttons before instantiating new list (impt for reset)
	for item in action_list.get_children():
		item.queue_free()
	
	for action: String in SettingsManager.INPUT_MAPPINGS:
		var button: Button = input_button.instantiate()
		var action_label: Label = button.find_child("ActionLabel")
		var input_label: Label = button.find_child("InputLabel")
		
		var action_name: String = input_actions[action]
		
		# if it is a default action, no change to name
		if not UnlockManager.contains(action_name):
			action_label.text = action_name.capitalize()
		# if it is unlockable control, only display name when unlocked
		else:
			if UnlockManager.able_to(action_name):
				action_label.text = action_name.capitalize()
			else:
				# show locked controls ass ?????? and disable remapping
				action_label.text = "??????"
				button.disabled = true
		
		# current key binded to action
		var events: Array[InputEvent] = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().to_upper()
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
		# disables LMB double click
		if event is InputEventMouseButton and event.double_click:
				event.double_click = false
		
		# erase current keybind from action, then add new
		if (event is InputEventKey) or (event is InputEventMouseButton and event.is_pressed()):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			update_action_list(remapping_button, event)
			
			SettingsManager.INPUT_MAPPINGS[action_to_remap] = event
			SaveLoadManager.save_settings()
			
			is_remapping = false
			action_to_remap = ""
			remapping_button = null

func update_action_list(button: Button, event: InputEvent) -> void:
	button.find_child("InputLabel").text = event.as_text().to_upper()

func _on_reset_button_pressed() -> void:
	# load default controls from project settings and save
	InputMap.load_from_project_settings()
	
	for action: String in SettingsManager.INPUT_MAPPINGS:
		SettingsManager.INPUT_MAPPINGS[action] = InputMap.action_get_events(action)[0]
		
	SaveLoadManager.save_settings()
	create_action_list()
