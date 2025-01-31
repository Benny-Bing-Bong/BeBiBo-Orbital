extends State

@onready var col_shape: CollisionShape2D = $"../../CollisionShape2D"
@onready var head_raycast: RayCast2D = $"../../HeadRayCast2D"

func enter() -> void:
	super()
	col_shape.shape.size.y = 30
	col_shape.position.y = 9

func exit() -> void:
	col_shape.shape.size.y = 46
	col_shape.position.y = 1

func state_process(_delta: float) -> void:
	if not Input.is_action_pressed("down") and not head_raycast.is_colliding():
		go_back_move()

func go_back_move() -> void:
	transitioned.emit(self, "ground")
