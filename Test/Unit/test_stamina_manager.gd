extends GutTest

func before_each() -> void:
	StaminaManager.curr_refill_bar = StaminaManager.max_refill_bar
	await get_tree().create_timer(0.1).timeout

func test_has_charge() -> void:
	assert_true(StaminaManager.has_charge())

func test_not_has_charge() -> void:
	StaminaManager.curr_charge_bar = 0
	
	assert_false(StaminaManager.has_charge())

func test_use_charge() -> void:
	StaminaManager.use_charge()
	
	assert_between(StaminaManager.curr_charge_bar, 
		StaminaManager.max_charge_bar - 1, StaminaManager.max_charge_bar)

func test_stamina_refilling() -> void:
	StaminaManager.use_charge()
	var curr_value: float = StaminaManager.curr_refill_bar
	await get_tree().create_timer(0.5).timeout
	var new_value: float = StaminaManager.curr_refill_bar
	assert_gt(new_value, curr_value)
