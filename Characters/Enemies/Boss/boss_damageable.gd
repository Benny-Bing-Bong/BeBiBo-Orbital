extends Damageable

signal activate
signal agitate
signal die

var activated: bool = false
var agitated: bool = false

func take_damage(value: int) -> void:
	super(value)
	
	if not activated and health <= 50:
		emit_signal("activate")
		activated = true
	
	if not agitated and health <= 25:
		emit_signal("agitate")
		agitated = true

func _die() -> void:
	super()
	for child in get_parent().get_children():
		if child is EnemyStateMachine:
			child.emit_signal("interrupt_state", "dead")
	emit_signal("die")
