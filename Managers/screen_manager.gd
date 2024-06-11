extends Node

var layer: int = 1
var stack: Array # use pop_back and push_back, not the front versions

var screens: Dictionary = {
	"pause": preload("res://Screens/pause_screen.tscn"),
	"death": preload("res://Screens/death_screen.tscn"),
}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if not GameManager.on_main_screen and stack.is_empty():
			add_layer_to_screen("pause")
		else:
			remove_layer_from_screen()

func remove_all_layers() -> void:
	while not stack.is_empty():
		remove_layer_from_screen()

func add_layer_to_screen(name: String) -> void:
	var screen_resource: Resource = screens[name]
	
	if screen_resource: # if the screen exists
		layer += 1
		var screen: CanvasLayer = screen_resource.instantiate()
		
		# set the layer for the screen, and push it to the stack
		screen.layer = layer
		
		# pause the game if layer being added is pause
		if name == "pause":
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
