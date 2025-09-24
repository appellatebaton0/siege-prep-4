class_name DynamicAndCondition extends DynamicCondition

## Returns if all inputs are true

## The values to AND
@export var inputs:Array[DynamicValue]
var real_inputs:Array[DynamicValue]

func _ready() -> void:
	# If input is set, use that
	if inputs != null:
		real_inputs = inputs
	else:
		# Otherwise, look in children
		for child in get_children():
			if child is DynamicValue:
				real_inputs.append(child)
				break

func value() -> bool:
	var response = true
	
	for input in real_inputs:
		# If the value is null, OR
		# It's not true, fail.
		if input.value() == null or not input.value():
			response = false
	
	return response
