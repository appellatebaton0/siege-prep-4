extends Node
class_name Element

## The interface the element belongs to
@onready var interface:Interface = find_interface(4, self)
func find_interface(depth:int, from:Node) -> Interface:
	if depth <= 0:
		return null
	
	var parent = from.get_parent()
	
	if parent is Interface:
		return parent
	else:
		return find_interface(depth - 1, parent)

## Get the self as a Variant, for typecasting that
## bypasses faulty Intelli-sense
func get_me():
	return self
