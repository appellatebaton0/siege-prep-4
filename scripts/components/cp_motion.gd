extends Component
class_name MotionComponent
var me:CharacterBody2D = get_me()
func _init() -> void:
	component_id = "Motion"

# Allows the motioncomponent to be overridden by any node
var overrider:Node = null

# All the childed motion states
@onready var motion_states:Array[MotionState] = get_motion_states()
func get_motion_states() -> Array[MotionState]:
	var states:Array[MotionState]
	
	for child in get_children():
		if child is MotionState:
			states.append(child)
	
	return states

## The state the machine starts on.
@export var initial_state:MotionState
# The current state
var current_state:MotionState

func _ready() -> void:
	if initial_state != null:
		current_state = initial_state
	elif len(motion_states) > 0:
		current_state = motion_states[0]

func _process(delta: float) -> void:
	# Run each state's applicable function for processing
	for state in motion_states:
		if state == current_state:
			state.active(delta)
		else:
			state.inactive(delta)

func _physics_process(delta: float) -> void:
	# Run each state's applicable function for physics
	
	if overrider == null:
		for state in motion_states:
			if state == current_state:
				state.phys_active(delta)
			else:
				state.phys_inactive(delta)
	
	# Move & slide
	me.move_and_slide()
	
	if overrider == null:
		for state in motion_states:
			if state == current_state:
				state.post_phys_active(delta)
			else:
				state.post_phys_inactive(delta)
	
	# Apply the velocity to the actor instead of the component
	actor.global_position = me.global_position
	me.position = Vector2.ZERO

func _on_respawned():
	me.velocity = Vector2.ZERO
