extends DynamicValue
class_name DynamicNodesValue

## The node to either respond with, or do something with.
@export var nodes:Array[Node]

func value() -> Array[Node]:
	return nodes
