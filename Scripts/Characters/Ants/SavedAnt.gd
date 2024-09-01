extends CharacterBody2D

class_name SavedAnt

@onready var label : Label = $"Control/Label"
@onready var anim_player : AnimationPlayer = $AnimationPlayer
var ant : Ant = null

func _ready():
	label.text = "help"
	print("visible layer: ", get_visibility_layer())

func _physics_process(_delta):
	pass


func _on_area_2d_area_entered(area):
	if area.is_in_group("Ant"):
		label.text = "thanks"
		anim_player.play("saved")
		await get_tree().create_timer(1).timeout
		queue_free()
	elif area.is_in_group("ScalableObject"):
		label.text = ""


func _on_area_2d_area_exited(area):
	if area.is_in_group("ScalableObject"):
		label.text = "help"
