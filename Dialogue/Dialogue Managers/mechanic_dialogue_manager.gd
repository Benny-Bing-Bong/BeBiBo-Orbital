extends Node

@onready var mechanic_dialogue_resource: DialogueResource = preload(
	"res://Dialogue/Dialogues/mechanic_dialogue.dialogue")

# NOTE: keys in dict have to be the same as dialogue titles
var dialogues_done: Dictionary = {
	"new_game" : false,
	"first_thumbdrive" : false,
	"first_death" : false,
	"unlock_phaseshift" : false,
}

func try_dialogue(dialogue_name: String) -> void:
	if not dialogues_done.has(dialogue_name):
		return

	if dialogues_done[dialogue_name]: # if already done dialogue, return
		return

	dialogues_done[dialogue_name] = true
	DialogueManager.show_example_dialogue_balloon(mechanic_dialogue_resource, 
		dialogue_name)
# this can be another custom balloon

func load_dict(dict: Dictionary) -> void:
	for key: String in dict.keys():
		dialogues_done[key] = dict[key]

func save_dict() -> Dictionary:
	return dialogues_done

func reset_mechanic_dialogue() -> void:
	for key: String in dialogues_done.keys():
		dialogues_done[key] = false
