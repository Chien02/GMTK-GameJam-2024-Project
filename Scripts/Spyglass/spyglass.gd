extends Node2D

class_name Spyglass

@export_category("Dependencies")
@export var marker : Marker2D
@export var sprite : Sprite2D
@export var ui : Control
@export var focusing : Focusing
@export var slot_sprite : Sprite2D

@export_category("Camera Properties")
@export var cam_scale_in_UI : Vector2

var collected : bool = false # this use as flag when it was collected as a item
var spyglass_camera = SpyglassCamera.new()
var dnd = DragAndDrop.new() # dnd = Drag and Drop
var UI_phase : bool = false

func _ready():
	if Global.spyglass_collected:
		slot_sprite.visible = true
	else:
		slot_sprite.visible = false
	# Set up for drag and drop
	dnd.set_object($".")
	dnd.set_original_pos(marker.global_position)
	# Set up for camera focusing

func _process(_delta):
	handle_input()
	handle_camera_collision()

func _physics_process(_delta):
	var mouse_pos = get_global_mouse_position()
	if Global.spyglass_collected:
		dnd.drag_n_drop_physics_process(mouse_pos, _delta)

func handle_camera_collision():
	if !$SpyglassCamera.enabled:
		$UIArea/CollisionShape2D.set_deferred("disabled", true)
	else:
		$UIArea/CollisionShape2D.set_deferred("disabled", false)

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

func set_collected(value):
	Global.spyglass_collected = value
	var shape = CapsuleShape2D.new()
	shape.radius = 3.54
	shape.height = 18.37
	$"SpyglassArea/CollisionShape2D".set_deferred("shape", shape)
	if slot_sprite:
		slot_sprite.visible = true
		CustomAnimation.popping(slot_sprite, Vector2(1.8, 1.8), Vector2(1.4, 1.4), 0.5)

func _on_area_2d_mouse_entered():
	if !Global.spyglass_collected: return
	if !dnd.dragging:
		dnd.hover()

func _on_area_2d_mouse_exited():
	if !Global.spyglass_collected: return
	if !dnd.dragging:
		dnd.unhover()

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if !Global.spyglass_collected: return
	if Input.is_action_pressed("right click"):
		dnd.clicked = true
	if Input.is_action_just_released("right click"):
		dnd.clicked = false
		set_sprite_visible(true)
		spyglass_camera.switch_to_default_cam(Global.global_camera, $SpyglassCamera)
		UI_phase = false
		if focusing.focused_object:
			focusing.focused_object.label.visible = false
		focusing.remove_focused_object()


func _on_ui_area_area_entered(area):
	if area.is_in_group("ScalableObject"):
		if focusing.focused_object:
			# Replace focused object
			if focusing.focused_object._name != area.get_parent().name:
				focusing.remove_focused_object()
				focusing.set_focused_object(area.get_parent())
		else:
			# Set new focused object
			focusing.set_focused_object(area.get_parent())
		if !focusing.focused_object.measuring:
			focusing.focused_object.label.visible = true


func _on_ui_area_area_exited(area):
	if area.is_in_group("ScalableObject"):
		if focusing.focused_object:
			focusing.focused_object.label.visible = false
			focusing.remove_focused_object()
