extends Control

@export var pause : Control
var level1 = "res://Scenes/Scenes/Levels/level_1.tscn"

func _ready():
	$PlayButton.visible = Global.first_in_game
	$BackButton.visible = !Global.first_in_game

func _on_back_button_button_down():
	visible = false
	if pause:
		pause.visible = true

func _on_play_button_button_down():
	Global.first_in_game = false
	$PlayButton.visible = false
	get_tree().change_scene_to_file(level1)
