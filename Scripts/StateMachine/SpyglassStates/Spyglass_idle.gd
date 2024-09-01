extends SpyglassState
#spyglass idle

func enter():
	#print("Enter idle")
	pass

func exit():
	#print("Exit idle")
	pass

func process(_delta):
	pass

func physics_process(_delta):
	pass

func idle_handler():
	# If switch to UI state than idle emit signal to load state
	var flag = spyglass.get_UI_phase()
	if flag:
		Transition.emit(self, "Load")
