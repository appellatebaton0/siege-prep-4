extends RotationSpawnerComponent
class_name SpinRotationSpawnerComponent

## The starting rotation the spawner spawns actors with, in degrees.
@export var start_rotation:float = 0.0

## How much it spins every second
@export var spin_speed:float = 0.0

@onready var current_rotation = start_rotation

func _process(delta: float) -> void:
	current_rotation = wrap(current_rotation + (spin_speed * delta), 0, 360)

func get_rotation() -> float:
	return current_rotation
