extends Node2D

class_name Gate

var next_level = ""
var completed_level : bool = false
var can_change : bool = false

func _process(_delta):
	if can_change:
		can_change = false
		get_tree().change_scene_to_file(next_level)


func _on_area_2d_area_entered(area):
	if !completed_level: return
	if area.is_in_group("Ant"):
		can_change = true
