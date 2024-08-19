extends Node2D

class_name DragAndDrop

var original_pos : Vector2 # This position is use to return to when unhover object
var animated_object # Use for hover, unhover and scale
var init_z_index : int = 3

var dragging : bool = false
var draggable : bool = false
var clicked : bool = false # connect input from area2d in card

const SCALE_UP_VECTOR : Vector2 = Vector2(1.5, 1.5)
const SCALE_DOWN_VECTOR : Vector2 = Vector2(1, 1)
const SPEED : float = 20

func set_original_pos(glbl_pos):
	original_pos = glbl_pos

func set_object(object):
	animated_object = object

func drag_n_drop_physics_process(global_mouse_position, delta):
	if draggable and clicked or !draggable and clicked:
		dragging = true
	elif !clicked:
		dragging = false
	
	if dragging:
		follow_mouse(global_mouse_position, delta)
	else:
		unfollow_mouse(delta)

func follow_mouse(global_mouse_position, delta):
	animated_object.z_index = init_z_index + 1
	animated_object.global_position = lerp(animated_object.global_position, global_mouse_position, SPEED *delta)

func unfollow_mouse(delta):
	animated_object.global_position = lerp(animated_object.global_position, original_pos, SPEED * 1.5 * delta)
	if animated_object.global_position == original_pos:
		animated_object.z_index = init_z_index

func hover(): # use in _on_area_2d_mouse_entered()
	draggable = true
	CustomAnimation.hover(animated_object, SCALE_UP_VECTOR, Vector2(0, -10))

func unhover():# use in _on_area_2d_mouse_exited():
	draggable = false
	CustomAnimation.unhover(animated_object, SCALE_DOWN_VECTOR, original_pos)

