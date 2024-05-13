extends Node
class_name State

@export var can_move: bool = true

var character: CharacterBody2D
var playback: AnimationNodeStateMachinePlayback
var anim_sprite: AnimatedSprite2D

signal transitioned(state: State, new_state_name: String)

func enter() -> void:
	pass

func exit() -> void:
	pass

func state_input(input: InputEvent) -> void:
	pass

func state_process(delta: float) -> void:
	pass

func state_physics_process(delta: float) -> void:
	pass
