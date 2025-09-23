extends Component
class_name AreaComponent
var me:Area2D = get_me()

func _init() -> void:
	component_id = "Area"

func has_overlapping_collisions() -> bool:
	var bodies = me.get_overlapping_bodies()
	var areas = me.get_overlapping_areas()

	## If there's already none, save the trouble
	if len(bodies) <= 0 and len(areas) <= 0:
		return false
	
	## Get rid of areas & bodies that have the same actor
	for area in areas:
		var a = area
		if a is Component:
			if a.actor == actor:
				areas.erase(area)
	
	for body in bodies:
		var a = body
		if a is Component:
			if a.actor == actor:
				bodies.erase(body)
	
	# print(bodies, areas)
	
	## Return whether there are any left
	return len(bodies) > 0 or len(areas) > 0

@onready var sub_components:Array[AreaSubComponent] = get_sub_components()
func get_sub_components() -> Array[AreaSubComponent]:
	var return_array:Array[AreaSubComponent]
	
	for child in get_children():
		if child is AreaSubComponent:
			return_array.append(child)
	
	return return_array

# Turn a integer layer into an array for easier working
# Note, the place in the array and the layer value
# in the editor are offset by one. Layer 1 = [0]
# Also, no layer 32 because that's terrifying
func get_layer_as_array(layer:int) -> Array[bool]:
	var return_array:Array[bool] = [
		false,false,false,false,
		false,false,false,false,
		false,false,false,false,
		false,false,false,false,
		false,false,false,false,
		false,false,false,false,
		false,false,false,false,
		false,false,false
		]
	
	var highest_value:float = 30.0;
	while layer > 0:
		if layer >= int(pow(2.0, highest_value)):
			return_array[highest_value] = true
			layer -= int(pow(2.0, highest_value))
		highest_value -= 1
	
	return return_array
# Turn said array back into a collision layer
func get_array_as_layer(array:Array[bool]) -> int:
	var value:int = 0
	for i in range(len(array)):
		if array[i]:
			value += int(pow(2.0, i))
	return value

func layer_match(sub_component:AreaSubComponent, object:CollisionObject2D):

	var sub_comp_mask:Array[bool] = get_layer_as_array(sub_component.collision_mask)
	var obj_comp_layer:Array[bool] = get_layer_as_array(object.collision_layer)
	
	for i in range(len(sub_comp_mask)):
		if sub_comp_mask[i] and obj_comp_layer[i]:
			return true
	return false

func _on_area_entered(area:Area2D):
	var a = area
	if a is AreaComponent:
		if a.actor == actor:
			return
	# Run the area function for every valid subcomponent
	for component in sub_components:
		# Only do so if the component has a layer matching the area's
		if layer_match(component, area):
			component.on_area_entered(area)
	
func _on_body_entered(body:Node2D):
	# Run the body function for every valid subcomponent
	for component in sub_components:
		# Only do so if the component has a layer matching the body's
		if layer_match(component, body):
			component.on_body_entered(body)

func _process(delta: float) -> void:
	var bodies:Array[Node2D] = me.get_overlapping_bodies()
	var areas:Array[Area2D] = me.get_overlapping_areas()
	
	# Get rid of ones by this component's actor
	for area in areas:
		var a = area
		if a is AreaComponent:
			if a.actor == actor:
				areas.erase(area)
	
	for component in sub_components:
		
		## UPDATE OVERLAP DATA
		
		# If the area overlap has changed,
		# Update the component's data
		if component.overlapping_areas != areas:
				var valid_areas:Array[Area2D]
				
				for area in areas:
					if layer_match(component, area):
						valid_areas.append(area)
				
				component.overlapping_areas = valid_areas
	
		# If the body overlap has changed,
		# Update the component's data
		if component.overlapping_bodies != bodies:
			var valid_bodies:Array[Node2D]
			
			for body in bodies:
				if layer_match(component, body):
					valid_bodies.append(body)
			
			component.overlapping_bodies = valid_bodies
		
		
		## RUN SPECIFIC COLLISION FUNCTIONS
		# while colliding bodies / areas
		# while no colliding bodies / areas
		
		# Run body functions
		if len(bodies) > 0:
			
	
			# If it has overlapping areas, run accordingly
			if len(component.overlapping_bodies) > 0:
				component.while_colliding_bodies(component.overlapping_bodies, delta)
			# Otherwise, run the no function
			else:
				component.while_no_colliding_bodies(delta)
		else:
			component.while_no_colliding_bodies(delta)
		
		# Run area functions
		if len(areas) > 0:
			# If the overlap has changed,
			# Update the component's data
			
			# If it has overlapping areas, run accordingly
			if len(component.overlapping_areas) > 0:
				component.while_colliding_areas(component.overlapping_areas, delta)
			# Otherwise, run the no function
			else:
				component.while_no_colliding_areas(delta)
		else:
			component.while_no_colliding_areas(delta)
		
		
		## RUN GENERAL COLLISION FUNCTIONS
		# while no collision at all
		# while any collision at all
		
		# If there's no bodies OR areas, run the corresponding function
		if len(component.overlapping_bodies) <= 0 and len(component.overlapping_areas) <= 0:
			component.while_no_collisions(delta)
		else:
			component.while_any_collisions(delta)
		

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	for component in sub_components:
		component.on_input_event(viewport, event, shape_idx)
