extends OptionsSpawnerComponent
class_name RandomOptionsSpawnerComponent
func _init():
	component_id = "RandomOptionsSpawner"

## Actor spawn options.
@export var options:Array[PackedScene]

func get_options() -> Array[PackedScene]:
	return [options.pick_random()]
