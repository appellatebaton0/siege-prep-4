extends Component
class_name PivotLookComponent
var me:Node2D = get_me()

func _process(delta: float) -> void:
	me.look_at(me.get_global_mouse_position())
