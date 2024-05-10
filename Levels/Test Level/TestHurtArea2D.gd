extends Area2D

@onready var count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	print("Area Entered Detected. Count: " + str(count) + "| Area Name: " + area.get_name())
	count += 1
	area.get_name()
