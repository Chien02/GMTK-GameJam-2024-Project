extends Node2D

class_name ScalableObject

@export var sprite : Sprite2D
@export var rigid : RigidBody2D
@export var area : Area2D
@export var timer : Timer
@export var _name : String
@export var init_scale = 0
@export var label : Label # Display mass when spyglass is using
@export var collider_list : Array[CollisionShape2D] = []

var measuring_names = ["-5x", "-4x", "-3x", "-2x", "1x", "2x", "3x", "4x", "5x"]
var mass_scales = {
	"-0.5": 1000,
	"0.25": 25,
	"0.5": 50,
	"0.75": 75,
	"1": 100,
	"1.25": 125,
	"1.5": 150,
	"1.75": 175,
	"2": 200
}
var measuring_scale = {
	"-5x": -0.5,
	"-4x": 0.25,
	"-3x": 0.5,
	"-2x": 0.75,
	"1x": 1,
	"2x": 1.25,
	"3x": 1.5,
	"4x": 1.75,
	"5x": 2
}

signal Pick
signal finished

const DEFAULT_SHAPE_SIZE : float = 32.0
var current_scale_value : float
var current_mass : int
var body : CharacterBody2D

var measuring : bool = false # stop display mass when measuring

func _ready():
	_name = name
	init_scale_value()
	if label:
		label.visible = false

func _process(_delta):
	label.text = str(current_mass)

func _physics_process(_delta):
	for collider in collider_list:
		if collider.get_parent() is RigidBody2D:
			collider.global_position = global_position
	#if flag_apply_force:
		#rigid.apply_force(body.velocity, body.global_position - global_position)

# Generate random scale's value based on 4x scale
func init_scale_value():
	var rand_key = measuring_names.pick_random()
	if init_scale == 0:
		init_scale = measuring_scale[rand_key]
	current_mass = mass_scales[str(init_scale)]
	change_scale(init_scale)


# Not also change sprite's scale, but also rig_collider's scale
func change_scale(value: float):
	var new_size = value * Vector2.ONE
	current_mass = mass_scales[str(value)]
	current_scale_value = value
	sprite.scale = new_size
	for collider in collider_list:
		collider.scale = new_size


# After certain time, this object will return to it initialized scale
func reset_scale():
	current_scale_value = init_scale
	change_scale(init_scale)


func be_invisible():
	visible = false
	for collider in collider_list:
		collider.set_deferred("disabled", true)
	finished.emit()

func be_visible():
	visible = true
	for collider in collider_list:
		collider.set_deferred("disabled", false)
		collider.rotation = 0

func get_current_scale_value():
	return current_scale_value

func get_current_mass():
	return current_mass

func set_global_pos(pos):
	global_position = pos
	be_visible()


func _on_timer_timeout():
	reset_scale()
