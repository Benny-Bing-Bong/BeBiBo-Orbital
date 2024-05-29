extends Node

signal tutorial_triggered(tutorial_string: String)

# the values here are the defaults, set when player opens the game for the
#first time
var unlock_dictionary: Dictionary = {
	"jump": false,
	"double_jump": false,
	"crouch": false,
	"dash": false,
	"wallhang": false
	}

# check if can do given action, and returns it. Default value if not found
#is false
func able_to(action: String) -> bool:
	return unlock_dictionary.get(action, false)

# first check if the key is being tracked by the dictionary. if it is,
#set its value to true
func unlock(action: String) -> void:
	if unlock_dictionary.has(action):
		unlock_dictionary[action] = true

func reset_unlocks() -> void:
	for key: String in unlock_dictionary.keys():
		unlock_dictionary[key] = false

func load_dictionary(dict: Dictionary) -> void:
	for key: String in dict.keys():
		unlock_dictionary[key] = dict[key]

func save_dictionary() -> Dictionary:
	return unlock_dictionary

func trigger_tutorial(tutorial_string: String) -> void:
	tutorial_triggered.emit(tutorial_string)
