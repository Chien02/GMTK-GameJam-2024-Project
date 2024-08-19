extends Node

class_name StateMachine

@export var init_state : State

var states : Dictionary = {}
var current_state : State
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(on_child_transition)
	if init_state:
		init_state.enter()
		current_state = init_state


func _process(delta):
	if current_state:
		current_state.process(delta)
	
func _physics_process(delta):
	if current_state:
		current_state.physics_process(delta)
	
func on_child_transition(state, new_state_name):
	if state != current_state: return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state: return
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
