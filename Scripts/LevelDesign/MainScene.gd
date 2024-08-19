extends Node2D
# Main scene

@onready var camera : Camera2D = $Camera2D

func _ready():
	Global.set_global_camera(camera)
