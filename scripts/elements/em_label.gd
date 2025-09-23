extends Element
class_name EM_Label

@export var values:Array[DynamicValue]

var me:Label = get_me()

## Use {x} to substitue values, with x being the index in the values array.
@export var text_format:String = "{0}"

func _ready() -> void:
	_update_label()

func _process(_delta: float) -> void:
	_update_label()


func _update_label():
	print(values)
	if len(values) < 0:
		return
	
	var real_values:Array[Variant]
	for value in values:
		real_values.append(value.value())
	
	var real_text:String = text_format
	
	for i in range(len(values)):
		real_text = real_text.replace("{" + str(i) + "}", str(real_values[i]))
	
	me.text = real_text
	
