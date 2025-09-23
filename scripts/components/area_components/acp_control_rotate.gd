extends AreaSubComponent
class_name ControlRotateAreaSubComponent # whew that's a mouthful
func _init() -> void:
	component_id = "ControlRotateAreaSub"

signal rotated
signal rotated_left
signal rotated_right

@export var positive_input:String = "RotRight"
@export var negative_input:String = "RotLeft"

@export_range(0.0, 360.0) var rotation_amount:float 

func while_colliding_bodies(_bodies:Array[Node2D], _delta:float) -> void:
	if Input.is_action_just_pressed(positive_input):
		actor.rotate(deg_to_rad(rotation_amount))
		rotated.emit()
		rotated_right.emit()
	elif Input.is_action_just_pressed(negative_input):
		actor.rotate(deg_to_rad(-rotation_amount))
		rotated.emit()
		rotated_left.emit()
