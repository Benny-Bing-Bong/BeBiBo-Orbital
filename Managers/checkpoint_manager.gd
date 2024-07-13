extends Node

var checkpoint_dictionary: Dictionary = {
	"Level1-1": false,
	"Level1-3": false,
	"Level1-5": false,
	"Level2-2": false,
}

func update_checkpoint(level_name: String) -> void:
	if checkpoint_dictionary.has(level_name):
		checkpoint_dictionary[level_name] = true

func has_reached_checkpoint(level_name: String) -> bool:
	if not checkpoint_dictionary.has(level_name):
		return false
	
	return checkpoint_dictionary[level_name]

func reset_checkpoints() -> void:
	for key: String in checkpoint_dictionary.keys():
		checkpoint_dictionary[key] = false

func load_dictionary(dict: Dictionary) -> void:
	for key: String in dict.keys():
		checkpoint_dictionary[key] = dict[key]

func save_dictionary() -> Dictionary:
	return checkpoint_dictionary
