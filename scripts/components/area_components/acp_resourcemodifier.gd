extends AreaSubComponent
class_name ResourceModifierAreaSubComponent # Jesus
func _init() -> void:
	component_id = "ResourceModifierAreaSub"

signal modified_resource

## The resource ids to mask for
@export var resource_ids:Array[String]

## Value pairs of modifiers, typed [path_to_variable]:[value_to_set]
@export var modifiers:Dictionary[String, Variant]

# for every node that's colliding with this,
# find its resurce of a type and modify a certain value to a new one



func on_area_entered(area:Area2D) -> void:
	if not actor.is_active():
		return
	
	# Look for any ResourceComponents with 
	# the right id in collisions
	var a = area
	if a is Component:
		for component in a.actor.get_components():
			if component is ResourceComponent:
				if resource_ids.has(component.id):
					# Found one! Set the specified values to what
					# they should be.
					# Remember to use change_value not resource.set so it updates.
					for key in modifiers.keys():
						component.change_value(key, modifiers[key])
					modified_resource.emit()

func on_body_entered(body:Node2D) -> void:
	if not actor.is_active():
		return
	
	# Look for any ResourceComponents with 
	# the right id in collisions
	var b = body
	if b is Component:
		for component in b.actor.get_components():
			if component is ResourceComponent:
				if resource_ids.has(component.id):
					# Found one! Set the specified values to what
					# they should be.
					# Remember to use change_value not resource.set so it updates.
					for key in modifiers.keys():
						component.change_value(key, modifiers[key])
					modified_resource.emit()
