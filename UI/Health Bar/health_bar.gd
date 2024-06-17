extends Control

@export var core_normal: Texture2D
@export var core_broken: Texture2D

@onready var heart1: Sprite2D = $Heart1Sprite2D
@onready var heart2: Sprite2D = $Heart2Sprite2D
@onready var heart3: Sprite2D = $Heart3Sprite2D

func _ready() -> void:
	PlayerManager.connect("on_health_changed", update_bar)
	update_bar(PlayerManager.curr_health)

func update_bar(curr_health: int) -> void:
	if curr_health >= 3:
		heart3.texture = core_normal
	elif curr_health < 3:
		heart3.texture = core_broken
	
	if curr_health >= 2:
		heart2.texture = core_normal
	elif curr_health < 2:
		heart2.texture = core_broken
	
	if curr_health >= 1:
		heart1.texture = core_normal
	elif curr_health < 1:
		heart1.texture = core_broken
