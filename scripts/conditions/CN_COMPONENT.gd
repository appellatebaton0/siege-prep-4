extends Condition
class_name COMPONENTCondition

# Pull a bool value from a commponent using its actor and id

## The path to the actor to pull from.
@export var actor:Actor
## The component_id (name of the component's class - Component, ie Area)
@export var component_id:String
## The instance of the component to look for from the top down.
@export var occurence:int = 0
var component:Component

## The path to a value in the component. Hopefully a bool. 
## Also works for checking if a node exists. (ie, "actor" or "actor.condition.component_id")
## Leave blank to get whether an actor has a component with component_id
@export var bool_path:String

func valid() -> bool:
	
	if not is_instance_valid(actor):
		return false
	
	# Find the component that the id of was given
	var found:bool = false 
	var found_occurence:int = 0
	for ac_component in actor.get_components():
		if ac_component.component_id == component_id:
			if found_occurence == occurence:
				component = ac_component
				found = true
				break
			found_occurence += 1
	
	if actor == null or component == null:
		print("init failed")
		return false # Something went wrong with initialization, or the component didn't exist
	
	
	
	# If no bool path, just return if the component was found 
	if bool_path == "":
		return found
	
	
	# Split the value into subvalues for every "."
	# So you can get subvalues >:D
	var sub_values:Array[String]
	var real_path:String = bool_path
	while true:
		var find_value:int = real_path.find(".")
		# IF "."s
		if find_value != -1:
			sub_values.append(real_path.left(find_value))
			real_path = real_path.erase(0, find_value + 1)
		# IF no "."s
		else:
			sub_values.append(real_path)
			break
	
	# Travel down the subvalue list to get the value
	var this_value = null
	while len(sub_values) > 0:
		if this_value == null:
			## Get the value of the component + support for calling functions instead of straight values
			this_value = component.get(sub_values[0]) if not sub_values[0].contains("()") else component.call(sub_values[0].replace("()", ""))
			sub_values.pop_front()
		else:
			## Get the value of the component + support for calling functions instead of straight values
			this_value = this_value.get(sub_values[0]) if not sub_values[0].contains("()") else this_value.call(sub_values[0].replace("()", ""))
			sub_values.pop_front()
	
	# If it's a thing and exists, true
	if this_value is Node or this_value is Resource:
		return true
	# If it's an array, return whether there's anything in it.
	elif this_value is Array:
		return len(this_value) > 0
	# If it doesn't exist, false
	elif this_value == null:
		return false
	# If it's a bool, return it.
	elif this_value is bool:
		return this_value
	return false
	
