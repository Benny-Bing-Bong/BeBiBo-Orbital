extends CanvasLayer

@onready var v_box_container: VBoxContainer = $VBoxContainer

var scroll_speed: float = 30.0
var wait_done: bool = false

func _ready() -> void:
	GameManager.on_main_screen = true
	GameMusic.play_game_music()
	
	await get_tree().create_timer(3).timeout
	wait_done = true

func _process(delta: float) -> void:
	if not wait_done:
		return
	
	if Input.is_action_pressed("attack"):
		scroll_speed = 150
	else:
		scroll_speed = 30
	
	v_box_container.position.y -= scroll_speed * delta

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		SceneManager.transition_to_scene("Main")
