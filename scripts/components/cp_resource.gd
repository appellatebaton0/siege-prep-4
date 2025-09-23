extends Component
class_name ResourceComponent
func _init() -> void:
	component_id = "Resource"

signal value_changed(value:String, to:Variant)

## How this resource is identified - for use by other Components/Elements
@export var id:String
## The resource this componenet stores for other Component/Element use.
@export var resource:Resource

func change_value(value:String, to:Variant):
	if value == "":
		resource = to
	else:
		resource = resource.duplicate()
		resource.set(value, to)
	
	value_changed.emit(value, to)

func get_value(value:String = "") -> Variant:
	if value == "":
		return resource
	
	return resource.get(value)
