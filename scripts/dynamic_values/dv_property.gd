class_name DynamicPropertyValue extends DynamicValue

## The node to get a property from. NOTE: will look in children for this automatically.
@export var input:DynamicNodeValue
var real_input:DynamicNodeValue

@export var property:String
var sub_values:Array[String]

func _ready() -> void:
	# Prioritize the specifically set input
	if input != null:
		real_input = input
	# if there is none, look in children.
	else:
		for child in get_children():
			if child is DynamicNodeValue:
				real_input = child
				break # if you find one, break.
	
	# Turn the property into an array of subvalues.
	while property != "":
		# Get the index of the first period
		var period_index = property.find(".")
		
		# Get the value up to that period if it exists.
		var sub_value = property.left(period_index) if period_index != -1 else property
		
		# Add that value to the list
		sub_values.append(sub_value)
		
		# Cut the value out of the property
		if period_index != -1:
			property = property.right(len(property) - period_index - 1)
		else:
			property = ""


func get_property_of(node:Node, prop:String):
	var is_call = prop.contains("()")
	
	if is_call:
		return node.call(prop.replace("()", ""))
	else:
		return node.get(prop)

func value() -> Variant:
	var response:Variant = null
	
	# Iterate down the values to get the final value.
	for sub_value in sub_values:
		if response == null:
			response = get_property_of(real_input.value(), sub_value)
		elif response is Node:
			response = get_property_of(response, sub_value)
	
	return response
