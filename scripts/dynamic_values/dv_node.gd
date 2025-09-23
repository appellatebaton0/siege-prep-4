extends DynamicValue
class_name NodeDynamicValue

## The node to either respond with, or do something with.
@export var node:Node

func value() -> Node:
	return node
