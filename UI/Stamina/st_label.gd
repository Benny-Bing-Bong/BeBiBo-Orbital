extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not UnlockManager.able_to("dash"):
		visible = false
	
	UnlockManager.connect("skill_unlocked", on_skill_unlocked)

func on_skill_unlocked(name: String) -> void:
	if name == "dash":
		visible = true
