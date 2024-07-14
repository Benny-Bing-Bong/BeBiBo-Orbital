extends Node

@export var sidequest_person_name: String

# if sidequest already cleared, queue_free the node and all enemies with it
func _ready() -> void:
	if DSM.has_completed_sidequest(sidequest_person_name):
		queue_free()

func _process(delta: float) -> void:
	if get_children().is_empty():
		DSM.finish_sidequest(sidequest_person_name)
		queue_free()
