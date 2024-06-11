extends Control

@onready var charge_progress_bar: ProgressBar = $ChargeProgressBar
@onready var refill_progress_bar: ProgressBar = $ChargeProgressBar/RefillProgressBar

func _ready() -> void:
	if not UnlockManager.able_to("dash"):
		visible = false
	
	charge_progress_bar.max_value = StaminaManager.max_charge_bar
	charge_progress_bar.value = StaminaManager.curr_charge_bar
	refill_progress_bar.max_value = StaminaManager.max_refill_bar
	refill_progress_bar.value = StaminaManager.curr_refill_bar
	
	UnlockManager.connect("skill_unlocked", on_skill_unlocked)

func _physics_process(delta: float) -> void:
	charge_progress_bar.value = StaminaManager.curr_charge_bar
	refill_progress_bar.value = StaminaManager.curr_refill_bar

func on_skill_unlocked(name: String) -> void:
	if name == "dash":
		visible = true
