extends Control

class_name Focusing

@export var slider : VSlider
@export var timer : Timer

var focused_object : ScalableObject
var current_scale : float
var visible_label_flag : bool = false

var measure = [-40, -30, -20, -10, 0, 10, 20, 30 ,40, 50]
var transfer_measure = {
	"-40": -.25,
	"-30": .25,
	"-20": .5,
	"-10": .75,
	"0": 1,
	"10": 1.25,
	"20": 1.5,
	"30": 1.75,
	"40": 2,
}

func _ready():
	focused_object = null
	current_scale = 1

func _process(_delta):
	handle_input()

func handle_input():
	if Input.is_action_just_pressed("scroll_up"):
		change_slider_value(5)
	if Input.is_action_just_pressed("scroll_down"):
		change_slider_value(-5)

func change_slider_value(_value):
	if !focused_object: return
	slider.value += _value
	
	for mark in measure:
		if slider.value == mark:
			focused_object.change_scale(transfer_measure[str(slider.value)])

func set_focused_object(object: ScalableObject):
	if !focused_object:
		focused_object = object
		focused_object._name = object.name
		set_current_value(object.current_scale_value)

func remove_focused_object():
	if focused_object:
		focused_object = null
		current_scale = 0
		slider.value = 0

func set_current_value(value):
	current_scale = value
	var keys = transfer_measure.keys()
	var values = transfer_measure.values()
	
	for idx in range(0, keys.size()):
		if value == values[idx]:
			slider.value = int(keys[idx])

func _on_timer_timeout():
	pass
