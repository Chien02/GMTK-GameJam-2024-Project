extends Node2D

class_name ScalableObject

@export var sprite : Sprite2D
@export var rigid : RigidBody2D
@export var area : Area2D
@export var timer : Timer
@export var _name : String

@onready var collider : CollisionShape2D = %CollisionShape2D

var measuring_names = ["-5x", "-4x", "-3x", "-2x", "1x", "2x", "3x", "4x", "5x"]
var measuring_scale = {
	"-5x": -0.25,
	"-4x": 0.25,
	"-3x": 0.5,
	"-2x": 0.75,
	"1x": 1,
	"2x": 1.25,
	"3x": 1.5,
	"4x": 1.75,
	"5x": 2
}

var init_scale = 1
var current_scale_value : float
#var flag_apply_force : bool = false
var body : CharacterBody2D

const MAX_SHAPE_SIZE = Vector2(100, 100)
const MIN_SHAPE_SIZE = Vector2(10, 10)

func _ready():
	_name = name
	init_scale_value()

func _physics_process(delta):
	collider.global_position = global_position
	#if flag_apply_force:
		#rigid.apply_force(body.velocity, body.global_position - global_position)

# Generate random scale's value based on 4x scale
func init_scale_value():
	var rand_key = measuring_names.pick_random()
	var rand_value = measuring_scale[rand_key]
	init_scale = rand_value
	print("From Scalable Object:", _name,".scale = ", init_scale)
	change_scale(init_scale)

# Not also change sprite's scale, but also collider's scale
func change_scale(value: float):
	var new_size = value * Vector2.ONE
	current_scale_value = value
	sprite.scale = new_size
	area.scale = new_size
	collider.scale = new_size

# After certain time, this object will return to it initialized scale
func reset_scale():
	current_scale_value = init_scale
	change_scale(init_scale)

func get_current_scale_value():
	return current_scale_value

func _on_timer_timeout():
	reset_scale()
