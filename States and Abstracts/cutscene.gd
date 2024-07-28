class_name Cutscene
extends Node2D

@export var player: Player
@export var player_camera: Camera2D
@export var hud: CanvasLayer
@export var cutscene_camera: Camera2D
@export var path_2d: Path2D
@export var path_follow_2d: PathFollow2D

var is_playing: bool = false
var played_cutscene: bool = false

func start_cutscene() -> void:
	await get_tree().create_timer(0.3).timeout
	player.stop_player()
	player.set_process_input(false)
	player_camera.enabled = false
	hud.visible = false
	cutscene_camera.enabled = true
	is_playing = true

func end_cutscene() -> void:
	cutscene_camera.enabled = false
	player_camera.enabled = true
	hud.visible = true
	is_playing = false
	played_cutscene = true
	player.set_process_input(true)
	player.enable_movement()
