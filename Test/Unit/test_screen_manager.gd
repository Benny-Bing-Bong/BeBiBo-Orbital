extends GutTest

func before_each() -> void:
	ScreenManager.layer = 1
	ScreenManager.stack = []

func test_adding_screen() -> void:
	ScreenManager.add_layer_to_screen("pause")
	
	assert_ne(ScreenManager.stack.size(), 0)

func test_has_screen() -> void:
	var key_name: String = ScreenManager.screens.keys()[0]
	
	assert_true(ScreenManager.has_screen(key_name))

func test_not_has_screen() -> void:
	assert_false(ScreenManager.has_screen("BABABOOEY"))

func test_remove_all_layers() -> void:
	var key_name: String = ScreenManager.screens.keys()[0]
	var key_name2: String = ScreenManager.screens.keys()[1]
	var key_name3: String = ScreenManager.screens.keys()[2]
	
	ScreenManager.add_layer_to_screen(key_name)
	ScreenManager.add_layer_to_screen(key_name2)
	ScreenManager.add_layer_to_screen(key_name3)
	ScreenManager.remove_all_layers()
	
	assert_true(ScreenManager.stack.is_empty())
