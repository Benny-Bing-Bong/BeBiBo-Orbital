extends Node
class_name EnemyStateMachine

@export var initial_state: State
@export var character: CharacterBody2D
@export var sprite: AnimatedSprite2D

signal interrupt_state(new_state: State)

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child # Add state to dictionary
			
			# Set up states with relevant character and playback
			child.character = character
			child.anim_sprite = sprite
			
			# Connect to transition signal to receive it
			child.transitioned.connect(on_child_transition)
		else:
			push_warning("Child " + child.name + " is not a State for PSM")
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state
	
	interrupt_state.connect(on_state_interrupt_state)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.state_input(event)

func _process(delta: float) -> void:
	if current_state:
		current_state.state_process(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.state_physics_process(delta)

func on_child_transition(state: State, new_state_name: String) -> void:
	if state != current_state: # check if the state calling this is current
		return
	
	var new_state: State = states.get(new_state_name.to_lower())
	if not new_state: # check if new state actually exists
		return
	
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()
	
func on_state_interrupt_state(new_state: String) -> void:
	on_child_transition(current_state, new_state)
