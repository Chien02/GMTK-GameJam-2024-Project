extends CharacterBody2D

class_name Ant

@export_category("Dependencies")
@export var anim_player: AnimationPlayer
@export var timer : Timer

@export_category("Properties")
@export var speed : float = 30
@export var accel : float = 10

@onready var marker : Marker2D = $Marker2D
@onready var label : Label = $"Control/Label"
@onready var camera_shake = get_tree().get_first_node_in_group("CameraShake")

var POWER = 100
const MASS = 10

var direction : Vector2
var last_direction : Vector2
var grabbable : bool = false
var grabbing : bool = false
var grabbing_object : ScalableObject = null
var grabbing_object_sprite : Sprite2D = null
var place_pos : Vector2
var allowed_to_place : bool = false

var interact : bool = false # use to handle events

func _ready():
	label.visible = false

func _process(_delta):
	pass

func _physics_process(_delta):
	direction = Input.get_vector("left", "right", "up", "down")
	
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	# Interact with ScalableObject
	# Calculate distance from own global_position to spot where place S.O
	interact_with_scalable_object()
	# Moving
	if direction != Vector2.ZERO:
		last_direction = direction
	move_and_slide()
	
	
func _on_area_2d_area_entered(area):
	if grabbing_object: return
	
	if area.is_in_group("ScalableObject"):
		var so : ScalableObject = area.get_parent() # so stands for ScalableObject
		if so.get_current_mass() > POWER:
			label.text = "too heavy"
		else:
			grabbable = true
			label.text = "grabbable"
			grabbing_object = so
		label.visible = true
		return
	
	if area.is_in_group("Spyglass"):
		if Global.spyglass_collected: return
		label.text = "collected"
		var spyglass = area.get_parent()
		spyglass.set_collected(true)
		label.visible = true
		timer.start()
	
	if area.is_in_group("HollowLogWood"):
		interact = true
		label.text = "enter"
		label.visible = true
		
	
func _on_area_2d_area_exited(area):
	if !grabbing:
		if timer.is_inside_tree():
			timer.start()
	grabbable = false
	if area.is_in_group("HollowLogWood"):
		interact = false

	if grabbing_object and !grabbing:
		grabbing_object = null
	
	
	
func interact_with_scalable_object():
	if grabbing:
		grabbable = false
		grab()
	
	if grabbable:
		if Input.is_action_just_pressed("grab"):
			set_up_grabbing_object()
			grab_event()
			await get_tree().create_timer(0.2).timeout
			allowed_to_place = true
			
	
func set_up_grabbing_object():
	grabbing_object.be_invisible()
	grabbing_object_sprite = Sprite2D.new()
	grabbing_object_sprite.texture = grabbing_object.get_node("Sprite2D").texture
	grabbing_object_sprite.scale = grabbing_object.current_scale_value * Vector2.ONE
	
	add_child(grabbing_object_sprite)
	set_grabbing_sprite_pos()
	
	
func clear_grabbing_object():
	if !grabbing_object: return
	grabbing_object = null
	remove_child(grabbing_object_sprite)
	grabbing_object_sprite = null
	
	grabbing = false
	grabbable = false
	allowed_to_place = false
	
	
func grab_event():
	grabbing = true

func grab():
	label.text = "grabbing"
	place_pos = set_grabbing_sprite_pos()
	
	if allowed_to_place and Input.is_action_just_pressed("grab"):
		place_grabbing_object(place_pos)
	
func set_grabbing_sprite_pos():
	if grabbing_object_sprite:
		var scale_value = grabbing_object.current_scale_value
		var so_x_size = grabbing_object_sprite.texture.get_width() / 2.0 * scale_value * last_direction
		var gap = last_direction * global_position.distance_to(marker.global_position)
		grabbing_object_sprite.global_position = global_position + gap + so_x_size
	return grabbing_object_sprite.global_position
	
func place_grabbing_object(pos):
	grabbing_object.set_global_pos(pos)
	grabbing_object.be_visible()
	camera_shake.apply_shake()
	clear_grabbing_object()

func print_gain_power():
	label.visible = true
	label.text = "power up"
	if timer.is_inside_tree():
		timer.start()

func gain_power(value):
	Global.power += value
	POWER = Global.power
	
# Display "collected" text
func _on_timer_timeout():
	if !grabbing and !grabbable and !interact:
		label.visible = false
