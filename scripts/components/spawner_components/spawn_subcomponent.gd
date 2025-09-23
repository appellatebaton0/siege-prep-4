@abstract
class_name SpawnerSubComponent extends Component

@onready var component:SpawnerComponent = get_parent()

func _ready() -> void:
	actor = component.actor
