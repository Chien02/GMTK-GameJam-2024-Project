extends Node2D

class_name Collectables

@export var powered_gain : int = 30
var can_collect = true

func _on_area_2d_area_entered(area):
	if area.is_in_group("ScalableObject"):
		can_collect = false
	
	if area.is_in_group("Ant") or area.is_in_group("SavedAnt"):
		if can_collect:
			collected()
			area.get_parent().print_gain_power()
			area.get_parent().gain_power(powered_gain)

func collected():
	Global.honeydew += 1
	print("From Honeydew: honeydew = ", Global.honeydew)
	$CPUParticles2D.emitting = true
	await get_tree().create_timer(0.5).timeout
	queue_free()


func _on_area_2d_area_exited(area):
	if area.is_in_group("ScalableObject"):
		can_collect = true
