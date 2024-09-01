extends Level


@export var gate : Gate

@onready var max_measure_zone = get_tree().get_nodes_in_group("MeasuringZone").size()
var signal_count : int = 0

func _ready():
	super._ready()
	Global.current_scene = current_scene
	if gate:
		gate.visible = false
		gate.next_level = next_scene

func _on_measuring_zone_enoughed():
	signal_count += 1
	if signal_count >= max_measure_zone:
		gate.visible = true
		gate.completed_level = true
		CustomAnimation.popping(gate, Vector2(1.5, 1.5), Vector2(1, 1), 0.5)

func _on_paused_button_button_down():
	get_tree().paused = true
	get_node("PauseMenu").get_node("Control").visible = true

func _on_reset_button_down():
	get_tree().reload_current_scene()
