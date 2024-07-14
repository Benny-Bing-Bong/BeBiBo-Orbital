extends Area2D

# This has to be the same name as the one in sidequest_completed_dict of 
#the dialogue_state_manager.gd
@export var sidequest_person_name: String
@export var sprite_texture: Texture2D

var player_in_range: bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var pickup_label: Label = $PickupLabel

func _ready() -> void:
	if DSM.has_completed_sidequest(sidequest_person_name):
		queue_free()
		return
	
	sprite_2d.texture = sprite_texture

func _process(delta: float) -> void:
	# This is to ensure that pickup label shows correct keybind
	pickup_label.text = ("Press " +  
			SettingsManager.INPUT_MAPPINGS["interact"].as_text().to_upper() + 
			" to pick up")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_in_range:
		DSM.finish_sidequest(sidequest_person_name)
		
		PlayerSFX.pick_up()
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	player_in_range = true
	pickup_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	player_in_range = false
	pickup_label.visible = false
