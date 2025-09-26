@abstract
class_name MotionState extends Component

## Switch to a different state if a DynamicValue is true, and the motionstate is the current one.
@export var switch_handles:Dictionary[DynamicValue, MotionState]

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
func phys_active(_delta:float):
	pass
func post_phys_active(_delta:float):
	pass
func active(_delta:float):
	pass

# Inactive
func phys_inactive(_delta:float):
	pass
func post_phys_inactive(_delta:float):
	pass
func inactive(_delta:float):
	pass

# On change
func on_active():
	pass
func on_inactive():
	pass
