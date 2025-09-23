@abstract
class_name DynamicValue extends Node

## An overridable class to respond with a value on command.

func value() -> Variant:
	return false

#
### The node to pull a value from
#@export var source:Node
#
#### The path to the actor to pull from.
##@export var actor_path:NodePath
##var actor:Actor
#### The component_id (name of the component's class - Component, ie Area)
##@export var component_id:String
#### The instance of the component to look for from the top down.
##@export var occurence:int = 0
##var component:Component
#
### The path to a value in the component. 
#@export var value_path:String
#
#func value() -> Variant:
	#
	#if source == null:
		#print("init failed: ", source)
		#return false # Something went wrong with initialization, or the component didn't exist
	#
	#
	## Split the value into subvalues for every "."
	## So you can get subvalues >:D
	#var sub_values:Array[String]
	#var real_path:String = value_path
	#while true:
		#var find_value:int = real_path.find(".")
		## IF "."s
		#if find_value != -1:
			#sub_values.append(real_path.left(find_value))
			#real_path = real_path.erase(0, find_value + 1)
		## IF no "."s
		#else:
			#sub_values.append(real_path)
			#break
	#
	## Travel down the subvalue list to get the value
	#var this_value = null
	#while len(sub_values) > 0:
		#if this_value == null:
			### Get the value of the component + support for calling functions instead of straight values
			#this_value = source.get(sub_values[0]) if not sub_values[0].contains("()") else source.call(sub_values[0].replace("()", ""))
			#sub_values.pop_front()
		#else:
			### Get the value of the component + support for calling functions instead of straight values
			#this_value = this_value.get(sub_values[0]) if not sub_values[0].contains("()") else this_value.call(sub_values[0].replace("()", ""))
			#sub_values.pop_front()
	#
	#return this_value
