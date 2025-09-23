extends MotionState
class_name FrictionMotionState

@export var friction:float = 1.1
@export var no_diagonals:bool = false

func phys_active(_delta):
	if no_diagonals:
		if abs(character.velocity.x) > abs(character.velocity.y):
			character.velocity.y = 0.0
		else:
			character.velocity.x = 0.0

func post_phys_active(_delta):
	character.velocity = Vector2.ZERO
