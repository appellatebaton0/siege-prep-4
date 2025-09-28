extends DynamicNodeValue
class_name DynamicComponentValue

## Responds with a component from an Actor node.

## The component_id to look for; the component's class - "Component", ie "Area" for AreaComponent
@export var component_id:String
@export var actor:Actor
## Get the nth occurence of this component in the actor.
@export_range(1,100) var occurence:int = 1

func value() -> Component:
	
	var response:Component = null
	
	var curence:int = 0
	for component in actor.get_components():
		# Not the right type, continue
		if component.component_id != component_id:
			continue
		
		curence += 1
		# Uses <= so it will return previous instances
		# if there's no newer instance
		if curence <= occurence:
			response = component
	
	return response
