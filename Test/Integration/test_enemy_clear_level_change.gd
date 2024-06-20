extends GutTest

var enemy_container_scene: PackedScene = preload(
		"res://Levels/enemy_container.tscn")
var change_level_area_scene: PackedScene = preload(
		"res://Levels/change_level_area_2d.tscn")

var enemy_container: EnemyContainer
var change_level_area: Area2D

func before_each() -> void:
	enemy_container = enemy_container_scene.instantiate()
	change_level_area = change_level_area_scene.instantiate()
	change_level_area._ready()

func after_each() -> void:
	enemy_container.free()
	change_level_area.free()

func test_clear_enemies_scenemanager_signal() -> void:
	watch_signals(SceneManager)
	
	gut.simulate(enemy_container, 20, .1)
	gut.simulate(SceneManager, 20, .1)
	
	assert_signal_emitted(SceneManager, 'enemies_cleared')

func test_scenemanager_signal_changelevelarea_monitoring() -> void:
	watch_signals(SceneManager)
	
	SceneManager.all_enemies_died()
	
	assert_true(change_level_area.monitoring)

func test_enemycontainer_scenemanager_changelevelarea() -> void:
	gut.simulate(enemy_container, 20, .1)
	
	assert_true(change_level_area.monitoring)
