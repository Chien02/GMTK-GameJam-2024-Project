extends Area2D

class_name MeasuringZone

@export var max_mass : int = 200
@onready var ant : Ant = get_tree().get_first_node_in_group("Ant")

var object_list = []
var current_mass

signal Enoughed

func _ready():
	current_mass = 0

func _process(_delta):
	$Control/Label.text = str(current_mass) + "/" + str(max_mass)
	if current_mass >= max_mass:
		current_mass = max_mass
	elif current_mass < 0:
		current_mass = 0
	
	# Control glint when ant's grabbing:
	if ant.grabbing:
		$Sprite2D.material["shader_parameter/flag"] = true
	else:
		$Sprite2D.material["shader_parameter/flag"] = false

func _on_area_entered(area):
	var value = 0
	if area.is_in_group("SpyglassUI"):
		$Control/Label.visible = true
		
	if area.is_in_group("ScalableObject"):
		var so : ScalableObject = area.get_parent()
		so.measuring = true
		object_list.append(so)
		value = so.current_mass
		
	elif area.is_in_group("Ant") or area.is_in_group("SavedAnt"):
		var _ant : Ant = area.get_parent()
		object_list.append(_ant)
		value = _ant.MASS
		
	if value != 0 and current_mass < max_mass:
		current_mass += value
		
	if current_mass >= max_mass:
		Enoughed.emit()


func _on_area_exited(area):
	if area.is_in_group("SpyglassUI"):
		$Control/Label.visible = false
	
	if area.is_in_group("ScalableObject"):
		area.get_parent().measuring = false
		current_mass -= area.get_parent().current_mass
	elif area.is_in_group("Ant") or area.is_in_group("SavedAnt"):
		current_mass -= area.get_parent().MASS
		
		
		var idx = object_list.find(area.get_parent())
		if idx:
			object_list.remove_at(idx)
			if object_list.is_empty():
				reset()

func reset():
	current_mass = 0
