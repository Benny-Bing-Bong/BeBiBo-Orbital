extends GutTest

var DamageableScript: Script = load("res://States and Abstracts/damageable.gd")

var _damageable: Damageable

func before_each() -> void:
	_damageable = DamageableScript.new()

func test_take_damage() -> void:
	var first_health: int = _damageable.health
	_damageable.take_damage(1)
	assert_lt(_damageable.health, first_health)
