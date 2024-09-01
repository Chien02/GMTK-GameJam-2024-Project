extends Node2D
# Custom Animation

const INIT_SCALE : Vector2 = Vector2.ONE

func scale(object, new_scale, duration):
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property(object, "scale", new_scale, duration)

func up(object, new_pos_y, duration):
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property(object, "position", object.position.y - new_pos_y, duration)

func down(object, new_pos_x, duration):
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property(object, "position", object.position.x - new_pos_x, duration)

func popping(object, new_scale: Vector2, old_scale: Vector2, duration: float):
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property(object, "scale", new_scale, duration/2)
	tween.tween_property(object, "scale", old_scale, duration/2)

func hover(object, new_scale: Vector2, _motion_amount: Vector2):
	#var new_pos : Vector2 = object.global_position + motion_amount
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(object, "scale", new_scale, 0.25).set_trans(Tween.TRANS_BOUNCE)
	#tween.parallel().tween_property(object, "global_position", new_pos, 0.2).set_trans(Tween.TRANS_LINEAR)
	
func unhover(object, old_scale: Vector2, _old_pos: Vector2):
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	#tween.tween_property(object, "global_position", old_pos, 0.25)
	tween.tween_property(object, "scale", old_scale, 0.25)

func move_to(object, _from, _to, duration: float):
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property(object, "global_position", _to, duration).from(_from)
