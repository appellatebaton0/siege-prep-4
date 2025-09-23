extends MotionState
class_name MouseMotionState

func phys_active(_delta:float):
	character.global_position = character.get_global_mouse_position()
	
