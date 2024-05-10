extends Sprite2D

@onready var total_damage: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(value: int) -> void:
	total_damage += value

func get_total_damage() -> int:
	return total_damage
