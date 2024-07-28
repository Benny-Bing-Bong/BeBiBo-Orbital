extends CanvasLayer

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var thank_you_label: Label = $ThankYouLabel

var scroll_speed: float = 30.0
var wait_done: bool = false
var thank_you_label_out: bool = false

func _ready() -> void:
	GameManager.on_main_screen = true
	GameMusic.play_game_music()
	thank_you_label.modulate = Color(0,0,0)
	thank_you_label.visible = false
	
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
	
	if v_box_container.position.y < -2100 and not thank_you_label_out:
		thank_you_label_out = true
		show_thank_you_label()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		SceneManager.transition_to_scene("Main")

func show_thank_you_label() -> void:
	thank_you_label.visible = true
	
	var _tween: Tween = get_tree().create_tween()
	_tween.tween_property(thank_you_label, "modulate", Color(1,1,1), 3)
