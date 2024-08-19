extends Node2D

class_name Spyglass

@export_category("Dependencies")
@export var marker : Marker2D
@export var sprite : Sprite2D
@export var ui : Control
@export var focusing : Focusing

@export_category("Camera Properties")
@export var cam_scale_in_UI : Vector2

var spyglass_camera = SpyglassCamera.new()
var dnd = DragAndDrop.new() # dnd = Drag and Drop
var UI_phase : bool = false

func _ready():
	# Set up for drag and drop
	dnd.set_object($".")
	dnd.set_original_pos(marker.global_position)
	# Set up for camera focusing

func _process(_delta):
	handle_input()

func _physics_process(_delta):
	var mouse_pos = get_global_mouse_position()
	dnd.drag_n_drop_physics_process(mouse_pos, _delta)

func handle_input():
	if Input.is_action_just_pressed("left click") and Input.is_action_pressed("right click"):
		UI_phase = sprite.visible
		set_sprite_visible(!sprite.visible)
		spyglass_camera.switch_spyglasscam(Global.global_camera, $SpyglassCamera)

func set_sprite_visible(value: bool):
	sprite.visible = value
	ui.visible = !value

func get_UI_phase():
	return UI_phase
# this func will zoom when change spyglass into it ui phase

func _on_area_2d_mouse_entered():
	if !dnd.dragging:
		dnd.hover()

func _on_area_2d_mouse_exited():
	if !dnd.dragging:
		dnd.unhover()

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("right click"):
		dnd.clicked = true
	else:
		dnd.clicked = false
		set_sprite_visible(true)
		spyglass_camera.switch_to_default_cam(Global.global_camera, $SpyglassCamera)
		UI_phase = false
		focusing.remove_focused_object()


func _on_ui_area_area_entered(area):
	if area.is_in_group("ScalableObject"):
		if focusing.focused_object:
			if focusing.focused_object._name != area.get_parent().name:
				focusing.remove_focused_object()
				focusing.set_focused_object(area.get_parent())
		else:
			focusing.set_focused_object(area.get_parent())



