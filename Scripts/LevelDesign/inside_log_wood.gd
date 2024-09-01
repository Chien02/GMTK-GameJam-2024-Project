extends Node2D



func _ready():
	var gate_list = $Gates.get_children()
	
	if !gate_list.is_empty():
		for gate in gate_list:
			gate.completed_level = true
			gate.next_level = Global.current_scene
			print("gate: ", gate.completed_level)
