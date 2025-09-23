extends VelocitySpawnerComponent
class_name RangeVelocitySpawnerComponent

## The x velocity range the spawner spawns actors with
@export var x_range:Vector2 = Vector2.ZERO
## The y velocity range the spawner spawns actors with
@export var y_range:Vector2 = Vector2.ZERO

func get_velocity() -> Vector2:
	
	var x = randf_range(x_range.x, x_range.y)
	var y = randf_range(y_range.x, y_range.y)
	
	return Vector2(x,y)
