class_name DynamicSingleGroupValue extends DynamicNodeValue

## Grabs one node from a group.

@export var group_name:String

## The index from the group to return. 0 for get_first_node_in_group
@export var index := 0
## Whether to just get a random node from the group
@export var random:bool = false

func value() -> Node:
	if group_name == null or group_name == "":
		return null
	
	# If random, get the nodes and return a random
	if random:
		return get_tree().get_nodes_in_group(group_name).pick_random()
	else: # Otherwise
		match index:
			0: # If it's zero just return the function for first.
				return get_tree().get_first_node_in_group(group_name)
			_: # If it's not zero, return the specified index.
				return get_tree().get_nodes_in_group(group_name)[index]
