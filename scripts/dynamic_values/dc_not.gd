class_name DynamicNotCondition extends DynamicCondition

## Returns the opposite of the input

## The value to NOT
@export var input:DynamicValue
var real_input:DynamicValue

func _ready() -> void:
	# If input is set, use that
	if input != null:
		real_input = input
	else:
		# Otherwise, look in children
		for child in get_children():
			if child is DynamicValue:
				real_input = child
				break

func value() -> bool:
	var response = real_input.value()
	
	if response is Node:
		response = response != null
	elif response is not bool:
		response = false
	
	return not response
