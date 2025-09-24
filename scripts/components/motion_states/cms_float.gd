extends ControlMotionState
class_name FloatControlMotionState
func _init():
	component_id = "FloatControlMotionState"

@export var max_speed:float = 90.0 ## The fastest the actor can go by just holding a direction

@export var friction:float = 5.0 ## How fast the actor slows down
@export var acceleration:float = 10.0 ## How fast the actor approaches MAX_SPEED

func phys_active(delta: float) -> void:
	var direction = Input.get_vector(input_left, input_right, input_up, input_down)
	
	# If the player's holding a direction, move in that direction.
	if direction:
		character.velocity = vec2_move_towards(character.velocity, direction * max_speed, 60 * delta * acceleration)
	else:
		character.velocity = vec2_move_towards(character.velocity, Vector2.ZERO, 60 * delta * friction)
