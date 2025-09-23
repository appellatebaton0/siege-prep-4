extends RotationSpawnerComponent
class_name ManualRotationSpawnerComponent

## The rotation the spawner spawns actors with, in degrees.
@export var rotation:float = 0.0

func get_rotation() -> float:
	return rotation
