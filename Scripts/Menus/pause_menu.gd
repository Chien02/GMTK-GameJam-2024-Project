extends CanvasLayer

var menu_scene = "res://Scenes/Menus/main_menu.tscn"
@export var tutorial_scene : Control
@export var pause_menu : Control

func _on_button_button_down():
	get_tree().paused = false
	pause_menu.visible = false


func _on_button_2_button_down():
	tutorial_scene.visible = true
	pause_menu.visible = false


func _on_button_3_button_down():
	pause_menu.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file(menu_scene)
