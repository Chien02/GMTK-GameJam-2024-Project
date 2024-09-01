extends Node2D
#Global

var first_in_game : bool = true

var global_camera_scale : float
var global_camera : Camera2D
var spyglass_collected : bool = false
var honeydew : int = 0
var power : int = 100

var current_scene : String

func _ready():
	first_in_game = true
	spyglass_collected = false

func set_global_camera(camera: Camera2D):
	global_camera = camera
