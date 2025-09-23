extends MotionState
class_name StraightMotionState

@export var direction:Vector2 = Vector2.ZERO

@export var max_speed:float = 90.0 ## The fastest the actor can go by just holding a direction
@export var acceleration:float = 10.0 ## How fast the actor approaches MAX_SPEED

func _ready() -> void:
	direction = direction.normalized()

func phys_active(delta:float):
	character.velocity = vec2_move_towards(character.velocity, direction * max_speed, acceleration)
	
