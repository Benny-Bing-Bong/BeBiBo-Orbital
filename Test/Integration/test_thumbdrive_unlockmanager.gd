extends GutTest

var thumbdrive_scene: PackedScene = preload("res://Items/thumbdrive.tscn")

var thumbdrive: Area2D

func before_each() -> void:
	thumbdrive = thumbdrive_scene.instantiate()
	thumbdrive.unlock_name = "jump"
	thumbdrive.player_in_range = true
	
	UnlockManager.reset_unlocks()

func after_each() -> void:
	thumbdrive.free()

func test_pickup_thumbdrive() -> void:
	# because inputsenders that are part of godot are dynamically typed, it
	#will show up as an error with the current statically typed settings.
	# To run this test, change Project Settings > Debug > GDScript >
	#Untyped Declaration to ignore first, then remove the comment on the main 
	#code, and comment out the fail_test() function.
	# REMEMBER TO REVERT YOUR CHANGES AFTER TESTING
	
	# Main Code
	#var sender = InputSender.new(thumbdrive)
	#autofree(sender)
	#
	#sender.action_down("interact")
	#
	#assert_true(UnlockManager.able_to("jump"))
	
	# Fail function
	fail_test("See the test for more information")
