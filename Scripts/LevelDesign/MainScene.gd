extends Node2D
# Main scene

class_name Level

@onready var camera : Camera2D = $Camera2D
@onready var ant : Ant = get_tree().get_first_node_in_group("Ant")

@export var current_scene : String
@export var marker : Marker2D
@export var next_scene : String
var finished : bool = false
var flag = false


func _ready():
	Global.set_global_camera(camera)

func _physics_process(_delta):
	if !finished:
		enter_scene(ant)
		if marker:
			ant.global_position = lerp(ant.global_position, marker.global_position, 0.9 * _delta)
			if ant.global_position == marker.global_position:
				finished = true


func enter_scene(_ant):
	if flag: return
	flag = true
	var tween = create_tween().set_loops(4).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.tween_property(_ant.get_node("AnimatedSprite2D"), "scale", Vector2(-1, 1), 0.15)
	tween.tween_property(_ant.get_node("AnimatedSprite2D"), "scale", Vector2(1, 1), 0.15)
	await tween.finished
	finished = true
	
