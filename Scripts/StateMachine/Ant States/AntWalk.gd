extends AntState


func enter():
	print("AntWalk say hello")
	switch_walk()

func exit():
	pass

func process(_delta):
	pass

func physics_process(_delta):
	set_anim_tree_blend_pos()
	if ant.velocity == Vector2.ZERO:
		Transition.emit(self, "idle")
	

func switch_walk():
	anim_tree["parameters/conditions/walk"] = true
	anim_tree["parameters/conditions/idle"] = false
