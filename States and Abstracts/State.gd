extends Node
class_name State

signal transitioned(state: State, new_state_name: String)

@export var can_move: bool = true
@export var first_anim_name: String

var character: CharacterBody2D
var playback: AnimationNodeStateMachinePlayback
var anim_sprite: AnimatedSprite2D

func enter() -> void:
	if anim_sprite:
		anim_sprite.play(first_anim_name)
	
	if playback:
		playback.travel(first_anim_name)

func exit() -> void:
	pass

func state_input(_input: InputEvent) -> void:
	pass

func state_process(_delta: float) -> void:
	pass

func state_physics_process(_delta: float) -> void:
	pass
