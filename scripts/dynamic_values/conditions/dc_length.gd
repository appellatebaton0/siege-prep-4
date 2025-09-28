extends DynamicCondition
class_name DynamicLengthCondition

## Returns if the length of an array / string matches criteria

## The input, an array / string
@export var input:DynamicValue

enum comparisons{GREATER_THAN, LESS_THAN, GREATER_OR_EQUAL, LESS_OR_EQUAL, EQUAL}
## The comparison to make between the input and comparator
@export var comparison := comparisons.EQUAL

## The value to compare the length to.
@export var comparator := 0

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicValue:
				input = child
				break

func value() -> bool:
	if input == null:
		return false
	
	var length = len(input.value())
	match comparison:
		comparisons.GREATER_THAN:
			return length > comparator
		comparisons.LESS_THAN:
			return length < comparator
		comparisons.GREATER_OR_EQUAL:
			return length >= comparator
		comparisons.LESS_OR_EQUAL:
			return length <= comparator
		comparisons.EQUAL:
			return length == comparator
	return false
