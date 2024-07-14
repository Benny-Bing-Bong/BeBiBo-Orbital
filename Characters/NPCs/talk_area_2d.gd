class_name TalkArea2D
extends Area2D

const BALLOON = preload("res://Dialogue/balloon.tscn")

@export var npc_dialogue_resource: DialogueResource

var player_in_range: bool = false

@onready var interact_label: Label = $InteractLabel

func _process(delta: float) -> void:
	interact_label.text = ("Press " + 
		SettingsManager.INPUT_MAPPINGS["interact"].as_text().to_upper() + 
		" to interact")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_in_range:
		var dia_balloon: Node = BALLOON.instantiate()
		get_tree().current_scene.add_child(dia_balloon)
		dia_balloon.start(npc_dialogue_resource, "start")

func _on_body_entered(body: Node2D) -> void:
	player_in_range = true
	interact_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	player_in_range = false
	interact_label.visible = false
