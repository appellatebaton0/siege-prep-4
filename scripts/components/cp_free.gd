extends Component
class_name FreeComponent
var me:Node = get_me()

signal got_free

@export var free_delay:float = 0.0
var free_time:float = 0.0
var freeing:bool = false

func free_actor():
	freeing = true
	got_free.emit()

func _process(delta: float) -> void:
	if freeing:
		if free_time >= free_delay:
			actor.queue_free()
		free_time += delta
