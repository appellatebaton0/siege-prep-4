extends VelocitySpawnerComponent
class_name ManualVelocitySpawnerComponent

## The velocity the spawner spawns actors with
@export var velocity:Vector2 = Vector2.ZERO

func get_velocity() -> Vector2:
	return velocity
