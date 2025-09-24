extends DynamicValue
class_name DynamicNodeValue

## The node to either respond with, or do something with.
@export var node:Node

func value() -> Node:
	return node
