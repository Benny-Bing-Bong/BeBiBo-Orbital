extends Node

var sidequest_completed_dict: Dictionary = {
	"Donn": false,
	"Moto": false,
	"Pooja": false,
	"Ross": false,
}

var first_interactions_completed_dict: Dictionary = {
	"Donn_inter": false,
	"Donn_quest_inter": false,
	"Moto_inter": false,
	"Moto_quest_inter": false,
	"Pooja_inter": false,
	"Pooja_quest_inter": false,
	"Ross_inter": false,
	"Ross_quest_inter": false,
}

func finish_sidequest(name: String) -> void:
	if sidequest_completed_dict.has(name):
		sidequest_completed_dict[name] = true

func finish_first_inter(name: String, quest: bool) -> void:
	var key: String

	if quest:
		key = name + "_quest_inter"
	else:
		key = name + "_inter"

	if first_interactions_completed_dict.has(key):
		first_interactions_completed_dict[key] = true

func has_completed_sidequest(name: String) -> bool:
	if not sidequest_completed_dict.has(name):
		return false


	return sidequest_completed_dict[name]

func has_completed_first_inter(name: String, quest: bool) -> bool:
	var key: String

	if quest:
		key = name + "_quest_inter"
	else:
		key = name + "_inter"

	if not first_interactions_completed_dict.has(key):
		return false


	return first_interactions_completed_dict[key]

func load_sidequest_dict(dict: Dictionary) -> void:
	for key: String in dict.keys():
		sidequest_completed_dict[key] = dict[key]

func load_inter_dict(dict: Dictionary) -> void:
	for key: String in dict.keys():
		first_interactions_completed_dict[key] = dict[key]

func save_sidequest_dict() -> Dictionary:
	return sidequest_completed_dict

func save_inter_dict() -> Dictionary:
	return first_interactions_completed_dict

func reset_dialogue_states() -> void:
	for key: String in sidequest_completed_dict.keys():
		sidequest_completed_dict[key] = false
	for key: String in first_interactions_completed_dict.keys():
		first_interactions_completed_dict[key] = false
