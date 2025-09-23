extends Component
class_name SpriteComponent
var me:Sprite2D = get_me()
func _init() -> void:
	component_id = "Sprite"

@export var resource_component:ResourceComponent
@export var resource_value:String

func _ready() -> void:
	if resource_component != null:
		resource_component.value_changed.connect(_on_value_changed)
		
		# Set it to itself, just to update.
		resource_component.change_value(resource_value, resource_component.get_value(resource_value))

# When the value it's using changes, update.
func _on_value_changed(value:String, to:Variant):
	if value == resource_value and to is Texture:
		me.texture = to
