extends Area2D

@export var unlock_name: String
@export_multiline var tutorial_string: String

var player_in_range: bool = false

@onready var pickup_label: Label = $PickupLabel
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# if related unlock has already been unlocked, remove from scene
	if UnlockManager.able_to(unlock_name):
		queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_in_range:
		UnlockManager.unlock(unlock_name)
		UnlockManager.emit_signal("tutorial_triggered", tutorial_string)
		
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	player_in_range = true
	pickup_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	player_in_range = false
	pickup_label.visible = false
