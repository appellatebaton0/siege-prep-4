extends AreaSubComponent
class_name ConsumerAreaSubComponent
func _init():
	component_id = "ConsumerAreaSub"

## Deletes actors it contacts
## and saves resources from them to
## save what it's eaten

## How long it takes for a consumed object to be
## forgotten, in seconds. -1 -> Never
@export var timeout_time:float = -1
## The ID of the resource to keep from the actors
@export var resource_id:String
## The values to compare in the resources to seperate
## them from each other.
@export var compare_values:Array[String]

# How many resources are currently in the dictionary,
# or effectively the amount/timeout_time
func get_total_rate():
	return len(consumed)

# Get the rate for a certain subset of values
# the dict is compare_value:match_value
func get_rate_for(values:Dictionary) -> int:
	
	# If it doesn't have all the searched for criteria.
	for value in compare_values:
		if not values.has(value):
			return 0
	
	var rate:int = 0
	
	for resource in consumed.keys():
		if resource is Resource: # it is, damn intellisense
			var passed:bool = true
			for value in compare_values:
				if resource.get(value) != values[value]:
					passed = false
			
			if passed:
				rate += 1
	
	return rate

# Get the rates in a dictionary of Resource:int.
func get_combo_rates() -> Dictionary[Resource, int]:
	var combo_rates:Dictionary[Resource, int]
	
	var value_combos = get_value_combos()
	
	var dupe_combos = value_combos.duplicate()
	for resource in consumed.keys():
		for combo in dupe_combos:
			# if the resource matches the combo,
			var is_a_match = true
			for value in compare_values:
				if resource.get(value) != combo[value]:
					is_a_match = false
			
			if is_a_match:
				combo_rates[resource] = get_rate_for(combo)
				
				dupe_combos.erase(combo)
	
	return combo_rates

# Get all the currently existing combonations
# of compare values
func get_value_combos() -> Array[Dictionary]:
	var combos:Array[Dictionary]
	
	for resource in consumed.keys():
		if resource is Resource:
			
			var this_set:Dictionary
			if len(combos) <= 0:
				# If no combos exist, this one's unique
				for value in compare_values:
					this_set[value] = resource.get(value)
				
				combos.append(this_set)
			else:
				var unique = true
				
				# If it's different from all existing combos,
				# it's unique
				for combo in combos:
					var matches_combo:bool = true
					
					# If any of the values don't match,
					# it doesn't match the combo.
					for value in compare_values:
						this_set[value] = resource.get(value)
						if not resource.get(value) == combo[value]:
							matches_combo = false
					
					# If it matches the combo, it's not
					# unique. Break and move on.
					if matches_combo:
						unique = false
						break
				
				# Add it to the list if it didn't match
				# any, and is therefore unique.
				if unique:
					combos.append(this_set)
	
	return combos

var consumed:Dictionary[Resource, Variant]

func _process(delta: float) -> void:
	if timeout_time >= 0:
		var timed_outs:Array[Resource]
		for resource in consumed.keys():
			consumed[resource] = move_toward(consumed[resource], 0, delta)
			
			if consumed[resource] <= 0:
				timed_outs.append(resource)
		
		for timed_out in timed_outs:
			consumed.erase(timed_out)

func on_area_entered(area:Area2D) -> void:
	
	var a = area
	if a is Component:
		var resources:Array[Resource]
		for component in a.actor.get_components():
			if component is ResourceComponent:
				if component.id == resource_id:
					resources.append(component.resource)
		
		for resource in resources:
			consumed[resource] = timeout_time
		
		a.actor.late_free()

func on_body_entered(body:Node2D) -> void:
	var b = body
	if b is Component:
		var resources:Array[Resource]
		for component in b.actor.get_components():
			if component is ResourceComponent:
				if component.id == resource_id:
					resources.append(component.resource)
		
		for resource in resources:
			consumed[resource] = timeout_time
		
		b.actor.late_free()
