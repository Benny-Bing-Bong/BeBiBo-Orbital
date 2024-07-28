extends Node

const BALLOON = preload("res://Dialogue/balloon.tscn")
@onready var mechanic_dialogue_resource: DialogueResource = preload(
	"res://Dialogue/Dialogues/mechanic_dialogue.dialogue")

# NOTE: keys in dict have to be the same as dialogue titles
var dialogues_done: Dictionary = {
	"new_game" : false,
	"first_thumbdrive" : false,
	"first_death" : false,
	"unlock_phaseshift" : false,
	"unlock_movement": false,
	"unlock_combat": false,
	"platforming": false,
	"meet_boss": false,
	"defeat_boss": false,
}

func try_dialogue(dialogue_name: String) -> void:
	if not dialogues_done.has(dialogue_name):
		return
	
	if dialogues_done[dialogue_name]: # if already done dialogue, return
		return
	
	dialogues_done[dialogue_name] = true
	
	# Instantiate and use the custom balloon
	var dia_balloon: Node = BALLOON.instantiate()
	get_tree().current_scene.add_child(dia_balloon)
	dia_balloon.start(mechanic_dialogue_resource, dialogue_name)

func force_dialogue(dialogue_name: String) -> void:
	if not dialogues_done.has(dialogue_name):
		return
	
	dialogues_done[dialogue_name] = false
	try_dialogue(dialogue_name)

func load_dictionary(dict: Dictionary) -> void:
	for key: String in dict.keys():
		dialogues_done[key] = dict[key]

func save_dictionary() -> Dictionary:
	return dialogues_done

func reset_mechanic_dialogue() -> void:
	for key: String in dialogues_done.keys():
		dialogues_done[key] = false
