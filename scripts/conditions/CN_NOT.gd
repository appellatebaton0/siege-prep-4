extends Condition
class_name NOTCondition

@export var condition:Condition

func valid() -> bool:
	return not condition.valid()

func initialize(with:Node):
	condition.initialize(with)
