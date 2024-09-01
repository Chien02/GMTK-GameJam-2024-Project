extends ScalableObject

class_name HollowLogWood

@onready var area1 = $Area1
@onready var area2 = $Area2

var is_enter : bool = false

var log_mass_scales = {
	"-0.25": 1000,
	"0.25": 5,
	"0.5": 25,
	"0.75": 50,
	"1": 75,
	"1.25": 100,
	"1.5": 125,
	"1.75": 150,
	"2": 175
}

var inside_log_path = "res://Scenes/Scenes/Levels/Puzzles/inside_log_wood.tscn"


func _ready():
	super._ready()
	mass_scales = log_mass_scales

func _process(delta):
	super._process(delta)
	if is_enter:
		if Input.is_action_just_pressed("ui_accept"):
			is_enter = false
			get_tree().change_scene_to_file(inside_log_path)


func change_scale(value):
	super.change_scale(value)
	var distance = self.position.distance_to(area1.position) / 3
	var scaled_pos = distance * current_scale_value
	area1.position = scaled_pos * Vector2.LEFT
	area2.position = scaled_pos * Vector2.RIGHT


func _on_area_1_area_entered(_area): # for in - out hollow log
	enter_inside_log(_area)

func _on_area_2_area_entered(_area): # for in - out hollow log
	enter_inside_log(_area)


func _on_area_2d_area_entered(_area):
	pass


func _on_area_1_area_exited(_area):
	exit_inside_log(_area)


func _on_area_2_area_exited(_area):
	exit_inside_log(_area)

func enter_inside_log(_area):
	if current_mass < 125:
		return
	if _area.is_in_group("Ant"):
		is_enter = true

func exit_inside_log(_area):
	if _area.is_in_group("Ant"):
		is_enter = false
