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
@export var requires_held:HoldableComponent 

func apply_to_held(rotation:float):
	if requires_held != null:
		requires_held.held_by.hold_offset = requires_held.held_by.hold_offset.rotated(deg_to_rad(rotation))

func while_colliding_bodies(_bodies:Array[Node2D], _delta:float) -> void:
	if requires_held == null or requires_held.held:
		if Input.is_action_just_pressed(positive_input):
			apply_to_held(rotation_amount)
			actor.rotate(deg_to_rad(rotation_amount))
			rotated.emit()
			rotated_right.emit()
		elif Input.is_action_just_pressed(negative_input):
			apply_to_held(-rotation_amount)
			actor.rotate(deg_to_rad(-rotation_amount))
			rotated.emit()
			rotated_left.emit()
