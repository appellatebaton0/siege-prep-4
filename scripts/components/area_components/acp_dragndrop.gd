extends AreaSubComponent
class_name DragNDropAreaSubComponent
@onready var me:Node = get_me()
func _init() -> void:
	component_id = "DragNDropAreaSub"

# Allows an actor to be picked up by the mouse

## Whether to only pick up/down an actor when the mouse is pressed
@export var toggle:bool = false

# Needs a HoldableComponent to manage it.
# This component ONLY tells it to pick it up.
@onready var holdable_component:HoldableComponent = get_holdable_component()
func get_holdable_component() -> HoldableComponent:
	for component in actor.get_components():
		if component is HoldableComponent:
			return component
	return null

func on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	# If the mouse is overlapping (provided mouse layers are set right)
	# and the event is right
	if has_collisions() and event is InputEventMouseButton:
		
		# If looking for any input,
		# or toggled and is a click down
		if not toggle or event.is_pressed():
			
			# Look for a HolderComponent in the current collisions
			for collision in get_collisions():
				var node = collision # Abstract type cause dum
				if node is Component:
					for component in node.actor.get_components():
						if component is HolderComponent:
							
							# If you find one, get uppies.
							holdable_component.hold_by(component)
