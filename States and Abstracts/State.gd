extends Node
class_name State

@export var can_move: bool = true
@export var first_anim_name: String

var character: CharacterBody2D
var playback: AnimationNodeStateMachinePlayback

signal transitioned(state: State, new_state_name: String)

func enter() -> void:
	playback.travel(first_anim_name)

func exit() -> void:
	pass

func state_input(input: InputEvent) -> void:
	pass

func state_process(delta: float) -> void:
	pass

func state_physics_process(delta: float) -> void:
	pass
