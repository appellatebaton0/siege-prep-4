extends Condition
class_name ORCondition

@export var conditions:Array[Condition]

func valid() -> bool:
	var validity = false
	
	# IF any are true, this is true.
	for condition in conditions:
		if condition.valid():
			validity = true
	
	return validity

func initialize(with:Node):
	for condition in conditions:
		condition.initialize(with)
