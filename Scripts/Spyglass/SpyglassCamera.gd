extends Camera2D

class_name SpyglassCamera

const ZOOM_UI_PHASE = Vector2(4, 4)
@export var speed : float = 20
@onready var spyglass = get_parent()

func _ready():
	zoom = ZOOM_UI_PHASE

func set_camera_zoom(vector):
	zoom = vector
	
func set_camera_zoom_default():
	zoom = ZOOM_UI_PHASE
	
func switch_spyglasscam(old_cam, new_cam):
	old_cam.enabled = !old_cam.enabled
	new_cam.enabled = !new_cam.enabled

func switch_to_default_cam(default_cam, old_cam):
	old_cam.enabled = false
	default_cam.enabled = true
