extends AntState

func enter():
	#print("AntIdle say hi")
	switch_idle()

func exit():
	pass

func process(_delta):
	pass


func physics_process(_delta):
	set_anim_tree_blend_pos()
	if ant.velocity != Vector2.ZERO:
		Transition.emit(self, "walk")


func switch_idle():
	anim_tree["parameters/conditions/walk"] = false
	anim_tree["parameters/conditions/idle"] = true
