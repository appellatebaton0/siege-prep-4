extends Component
class_name HolderComponent
var me:Node = get_me()
func _init() -> void:
	component_id = "Holder"

signal picked_up
signal put_down


var holding:Actor = null
var hold_offset:Vector2 = Vector2.ZERO

@export var hold_max_distance:float = 8.0

# Picking up and putting down
# Returns whether or not target was picked up
func hold(target:Actor) -> bool:
	if holding != null: # Already holding something
		if target == holding: # Trying to put it down
			holding = null
			put_down.emit()
			return false # Respond that it was put down
		else: # Trying to pick up a second thing
			return false # Respond that it wasn't picked up
	else: # Not holding anything
		holding = target
		hold_offset = target.global_position - actor.get_global_mouse_position()
		picked_up.emit()
		return true # Respond that it was picked up

func change_offset(to:Vector2):
	hold_offset = to

func _process(_delta: float) -> void:
	if holding != null:
		holding.global_position = actor.global_position + hold_offset
		if hold_offset.distance_to(Vector2.ZERO) > hold_max_distance:
			hold_offset /= 1.05
