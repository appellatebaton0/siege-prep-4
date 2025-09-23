extends Component
class_name UnrotatorComponent
func _init() -> void:
	component_id = "Unrotator"

# Literally just makes its parent ignore the rotation of the actor

@onready var parent:CanvasItem = get_parent()
@onready var parent_rotation:float = parent.rotation
func _process(_delta: float) -> void:
	parent.rotation = -actor.rotation
