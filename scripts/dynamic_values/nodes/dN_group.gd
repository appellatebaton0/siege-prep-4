extends DynamicNodesValue
class_name DynamicGroupValue

## Returns all existing nodes in a node-group

## The name of the group to get
@export var group_name:String

func value() -> Array[Node]:
	if group_name != null:
		return get_tree().get_nodes_in_group(group_name)
	return []
