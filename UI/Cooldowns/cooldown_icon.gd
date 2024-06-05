extends Control

@export var sprite_icon: Texture2D
@export var skill_name: String

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var timer_label: Label = $TimerLabel

func _ready() -> void:
	# if skill has not been unlocked yet, remove from scene
	if not UnlockManager.able_to(skill_name):
		queue_free()
		return
	
	sprite_2d.texture = sprite_icon
	timer_label.visible = false

func _process(delta: float) -> void:
	if not CooldownManager.skill_ready(skill_name):
		timer_label.text = "%.1f" % CooldownManager.get_remaining_time(skill_name)
		timer_label.visible = true
		sprite_2d.modulate = Color(0.5,0.5,0.5)
	else:
		timer_label.visible = false
		sprite_2d.modulate = Color(1,1,1)
