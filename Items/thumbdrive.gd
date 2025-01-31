extends Area2D

@export var unlock_name: String
@export var action_name: String
@export_multiline var tutorial_string: String

var player_in_range: bool = false

@onready var pickup_label: Label = $PickupLabel
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# if related unlock has already been unlocked, remove from scene
	if UnlockManager.able_to(unlock_name):
		queue_free()

func _process(delta: float) -> void:
	pickup_label.text = ("Press " + 
			SettingsManager.INPUT_MAPPINGS["interact"].as_text().to_upper() +
			" to pick up")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_in_range:
		UnlockManager.unlock(unlock_name, action_name, tutorial_string)
		
		if unlock_name == "jump":
			MDM.try_dialogue("first_thumbdrive")
		if unlock_name == "phaseshift":
			MDM.try_dialogue("unlock_phaseshift")
		if unlock_name == "crouch" or unlock_name == "wallhang":
			MDM.try_dialogue("unlock_movement")
		if unlock_name == "laser" or unlock_name == "bomb":
			MDM.try_dialogue("unlock_combat")
		
		PlayerSFX.pick_up()
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	player_in_range = true
	pickup_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	player_in_range = false
	pickup_label.visible = false
