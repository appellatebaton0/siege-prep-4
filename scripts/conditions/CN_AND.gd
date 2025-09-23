extends Condition
class_name ANDCondition

@export var conditions:Array[Condition]

func valid() -> bool:
	var validity = true
	
	# IF any are false, this is false.
	for condition in conditions:
		if not condition.valid():
			validity = false
	
	return validity

func initialize(with:Node):
	for condition in conditions:
		condition.initialize(with)
