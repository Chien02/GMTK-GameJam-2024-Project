extends CanvasLayer

var tutorial = "res://Scenes/Menus/Tutorial.tscn"
var level1 = "res://Scenes/Scenes/Levels/level_1.tscn"
@export var credit : Control

func _on_play_button_button_down():
	if Global.first_in_game:
		get_tree().change_scene_to_file(tutorial)
	else:
		get_tree().change_scene_to_file(level1)
#
#func _on_credit_button_button_down():
	#$Credit.visible = true
	#$Control.visible = false


func _on_button_button_down():
	$Credit.visible = false
	$Control.visible = true
