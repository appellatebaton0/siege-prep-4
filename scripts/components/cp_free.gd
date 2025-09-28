extends Component
class_name FreeComponent
var me:Node = get_me()
func _init():
	component_id = "Free"

@export var free_delay:float = 0.0
var free_time:float = 0.0
var freeing:bool = false

@export var conditions:Array[DynamicValue]

func _ready() -> void:
	for child in get_children():
		if child is DynamicValue:
			conditions.append(child)

func free_actor():
	freeing = true
	actor.freeing.emit()

func _process(delta: float) -> void:
	for condition in conditions:
		if condition.value():
			free_actor()
	
	if freeing:
		if free_time >= free_delay:
			actor.queue_free()
		free_time += delta
