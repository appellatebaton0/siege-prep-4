@abstract
class_name Component extends Node

var component_id:String = "Component"

func _init():
	## Functionless components are not allowed
	## OR 
	## There's a Component without a initialize
	## function for its component id.
	print(name, " failed.")
	assert(false)

## The actor the component belongs to
@onready var actor:Actor = find_actor()
func find_actor(depth:int = 5, with:Node = self) -> Actor:
	
	if depth <= 0:
		return null
	
	var answer:Actor = null
	
	if with is Actor:
		answer = with
	else:
		answer = find_actor(depth - 1, with.get_parent())
	
	return answer

# Get components
func get_components(depth:int = 4) -> Array[Component]:
	if depth <= 0:
		return []
	
	var components:Array[Component]
		
	for child in get_children():
		if child is Component:
			components.append(child)
			components.append_array(child.get_components(depth - 1))
	
	return components

## Get the self as a Variant, for typecasting that
## bypasses faulty Intelli-sense
func get_me():
	return self
