extends AreaSubComponent
class_name FuncCallerAreaSubComponent # Damn these are getting long.
func _init():
	component_id = "FuncCallerAreaSub"

## Calls functions on the colliding areas and bodies.

## The functions to call.
## The bool is whether or to run constantly,
## or just on contact.
@export var functions:Dictionary[String, bool]
## Used to find a specified component in the collider. Ignore the actor field.
@export var component_finder:DynamicComponentValue

# Look in the children for a DCV if needed.
func _ready() -> void:
	if component_finder == null:
		for child in get_children():
			if child is DynamicComponentValue:
				component_finder = child

func get_component(with:Node) -> Component:
	if component_finder != null and with is Actor:
		component_finder.actor = with
		return component_finder.value()
	return null

func call_for(node:Node, repeated:bool):
	print("called for ", node, repeated)
	if not actor.is_active():
		return
	if node is Component:
		var component:Component = get_component(node.actor)
		
		if component != null:
			for function in functions:
				if functions[function] == repeated:
					component.call(function)

func on_area_entered(area:Area2D) -> void:
	call_for(area, false)
func on_body_entered(body:Node2D) -> void:
	call_for(body, false)

func while_colliding_areas(areas:Array[Area2D], _delta:float) -> void:
	for area in areas:
		call_for(area, true)
func while_colliding_bodies(bodies:Array[Node2D], _delta:float) -> void:
	for body in bodies:
		call_for(body, true)
	
