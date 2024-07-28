extends CanvasLayer

@onready var v_box_container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	v_box_container.modulate = Color(0,0,0)
	
	# Fade in
	var _tween1: Tween = get_tree().create_tween()
	_tween1.tween_property(v_box_container, "modulate", Color(1,1,1), 1)
	
	await get_tree().create_timer(3).timeout
	
	# Fade out
	var _tween2: Tween = get_tree().create_tween()
	_tween2.finished.connect(go_to_next_scene)
	_tween2.tween_property(v_box_container, "modulate", Color(0,0,0), 1)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		go_to_next_scene()

func go_to_next_scene() -> void:
	SceneManager.transition_to_scene("Splash2")
