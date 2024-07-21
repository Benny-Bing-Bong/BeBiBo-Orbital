extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var detection_area: Area2D = $DetectionArea

var target: CharacterBody2D
var speed: float = 50

func _ready() -> void:
	animated_sprite_2d.play()

func _physics_process(delta: float) -> void:
	if target:
		navigation_agent_2d.target_position = target.global_position
		
	if navigation_agent_2d.is_navigation_finished():
		return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent_2d.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * speed
	move_and_slide()

func _on_detection_area_body_entered(body: CharacterBody2D) -> void:
	target = body
