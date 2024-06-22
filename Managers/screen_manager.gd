extends Node

var layer: int = 1
var stack: Array # use pop_back and push_back, not the front versions

var screens: Dictionary = {
	"pause": preload("res://Screens/pause_screen.tscn"),
	"death": preload("res://Screens/death_screen.tscn"),
	"checkpoint": preload("res://Screens/checkpoint_screen.tscn"),
	"unlocks": preload("res://Screens/unlocks_screen.tscn"),
	"move": preload("res://Screens/Unlock Screens/move_unlock_screen.tscn"),
	"attack": preload("res://Screens/Unlock Screens/attack_unlock_screen.tscn"),
	"jump": preload("res://Screens/Unlock Screens/jump_unlock_screen.tscn"),
	"double_jump": 
		preload("res://Screens/Unlock Screens/double_jump_unlock_screen.tscn"),
	"crouch": preload("res://Screens/Unlock Screens/crouch_unlock_screen.tscn"),
	"dash": preload("res://Screens/Unlock Screens/dash_unlock_screen.tscn"),
	"wallhang": 
		preload("res://Screens/Unlock Screens/wallhang_unlock_screen.tscn"),
	"phase": preload("res://Screens/Unlock Screens/phase_unlock_screen.tscn"),
	"laser": preload("res://Screens/Unlock Screens/laser_unlock_screen.tscn"),
}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if not GameManager.player_alive:
		return
	
	if event.is_action_pressed("esc"):
		if not GameManager.on_main_screen and stack.is_empty():
			add_layer_to_screen("pause")
		else:
			remove_layer_from_screen()
	if event.is_action_pressed("unlocks"):
		if not GameManager.on_main_screen and stack.is_empty():
			add_layer_to_screen("unlocks")

func remove_all_layers() -> void:
	while not stack.is_empty():
		remove_layer_from_screen()

func add_layer_to_screen(name: String) -> void:
	var screen_resource: Resource
	
	if screens.has(name):
		screen_resource = screens[name]
	else:
		return
	
	if screen_resource: # if the screen exists
		layer += 1
		var screen: CanvasLayer = screen_resource.instantiate()
		
		# set the layer for the screen, and push it to the stack
		screen.layer = layer
		
		# pause the game if layer being added is the first one
		# don't pause on death
		if stack.is_empty() and name != "death":
			get_tree().paused = true
		
		stack.push_back(screen)
		
		# add the screen to the scene
		add_child(screen)

func remove_layer_from_screen() -> void:
	if not stack.is_empty():
		layer -= 1
		var screen: CanvasLayer = stack.pop_back()
		
		# if stack is empty, means that we have gone back to game, so
		# resume the game
		if stack.is_empty():
			get_tree().paused = false
		
		# remove screen from scene
		screen.queue_free()

func has_screen(name: String) -> bool:
	return screens.has(name)
