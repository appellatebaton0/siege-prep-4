extends RotationSpawnerComponent
class_name BounceRotationSpawnerComponent

## The min / max rotation range
@export var range:Vector2
## How fast it moves, in angle per second
@export var speed:float = 0.0
## The starting rotation
@export var initial_rotation:float = 0.0

@onready var current_rotation:float = initial_rotation
var bounce:bool = false

func _process(delta: float) -> void:
	if bounce:
		current_rotation = move_toward(current_rotation, range.x, speed * delta)
		if current_rotation == range.x:
			bounce = false
	else:
		current_rotation = move_toward(current_rotation, range.y, speed * delta)
		if current_rotation == range.y:
			bounce = true
	pass

func get_rotation() -> float:
	return current_rotation
