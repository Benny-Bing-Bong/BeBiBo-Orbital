extends State

@onready var timer: Timer = $Timer
@onready var detection_area: Area2D = $"../../DetectionArea"

func enter() -> void:
	super()
	# wait one second. then reset monitoring property of detection_area
	#to allow tracking of player's position by enemy if player is still 
	#in detection area area
	timer.start()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if timer.is_stopped():
		warning()

func _on_timer_timeout() -> void:
	detection_area.monitoring = false
	detection_area.monitoring = true

func warning() -> void:
	transitioned.emit(self, "warning")
