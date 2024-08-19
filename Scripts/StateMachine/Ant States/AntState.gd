extends State

class_name AntState

@onready var ant : Ant = get_parent().get_parent() # State Machine -> Ant
@onready var anim_tree = %AnimationTree

func set_anim_tree_blend_pos():
	anim_tree["parameters/idle/blend_position"] = ant.direction
	anim_tree["parameters/walk/blend_position"] = ant.direction
