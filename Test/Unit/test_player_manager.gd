extends GutTest

func before_each() -> void:
	PlayerManager.set_health(PlayerManager.max_health)
	PlayerManager.inverted = false
	PlayerManager.jumped = false
	PlayerManager.double_jumped = false
	PlayerManager.air1ed = false
	PlayerManager.air2ed = false

func test_setting_health() -> void:
	PlayerManager.set_health(2)
	assert_eq(PlayerManager.curr_health, 2, "Pass on health is 2")

func test_setting_health_below_zero() -> void:
	PlayerManager.set_health(-1)
	assert_eq(PlayerManager.curr_health, 0, "Health should never be below zero")

func test_setting_health_above_max() -> void:
	PlayerManager.set_health(PlayerManager.max_health + 5)
	assert_eq(PlayerManager.curr_health, PlayerManager.max_health, 
			"Health should never be above max")

func test_jumping() -> void:
	PlayerManager.jumped = true
	assert_false(PlayerManager.can_jump())

func test_double_jumping() -> void:
	PlayerManager.double_jumped = true
	assert_false(PlayerManager.can_double_jump()) 

func test_reset_jump() -> void:
	PlayerManager.jumped = true
	PlayerManager.double_jumped = true
	PlayerManager.reset_jumps()
	assert_true(PlayerManager.can_jump() and PlayerManager.can_double_jump())
