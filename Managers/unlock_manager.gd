extends Node

signal tutorial_triggered(tutorial_string: String)
signal skill_unlocked(skill_name: String)

# the values here are the defaults, set when player opens the game for the
#first time
var unlock_dictionary: Dictionary = {
	"jump": false,
	"double_jump": false,
	"crouch": false,
	"dash": false,
	"wallhang": false,
	"phase": false,
	"laser": false,
	}

# check if can do given action, and returns it. Default value if not found
#is false
func able_to(action: String) -> bool:
	if action == "move" or action == "attack":
		return true
	
	return unlock_dictionary.get(action, false)

# first check if the key is being tracked by the dictionary. if it is,
#set its value to true
func unlock(skill_name: String, tutorial_string: String) -> void:
	if unlock_dictionary.has(skill_name):
		unlock_dictionary[skill_name] = true
		
		# trigger cooldown icons to show up on screen
		skill_unlocked.emit(skill_name)
		
		# trigger tutorial to pop up on screen
		tutorial_triggered.emit(tutorial_string)

func reset_unlocks() -> void:
	for key: String in unlock_dictionary.keys():
		unlock_dictionary[key] = false

func load_dictionary(dict: Dictionary) -> void:
	for key: String in dict.keys():
		unlock_dictionary[key] = dict[key]

func save_dictionary() -> Dictionary:
	return unlock_dictionary
