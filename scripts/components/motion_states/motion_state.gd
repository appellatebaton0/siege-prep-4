@abstract
class_name MotionState extends Component

@onready var component:MotionComponent = get_parent()
@onready var character:CharacterBody2D = component.me

func _ready() -> void:
	actor = component.actor

## Helper functions
func vec2_move_towards(a:Vector2, b:Vector2, delta:float):
	a.x = move_toward(a.x, b.x, delta)
	a.y = move_toward(a.y, b.y, delta)
	
	return a

## Ran functions

# Active
@abstract func phys_active(_delta:float)
@abstract func post_phys_active(_delta:float)
@abstract func active(_delta:float)

# Inactive
@abstract func phys_inactive(_delta:float)
@abstract func post_phys_inactive(_delta:float)
@abstract func inactive(_delta:float)

# On change
@abstract func on_active()
@abstract func on_inactive()
