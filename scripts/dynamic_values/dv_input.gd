class_name DynamicInputValue extends DynamicValue

## The name of the input to look for
@export var input_name:String = ""

enum types{
	just_pressed, ## If the input was just pressed.
	is_pressed ## If the input is pressed right now.
	}
## The type of input scanning to use
@export var scan_type:types

func value() -> bool:
	match scan_type:
		types.just_pressed:
			return Input.is_action_just_pressed(input_name)
		types.is_pressed:
			return Input.is_action_pressed(input_name)
	return false
