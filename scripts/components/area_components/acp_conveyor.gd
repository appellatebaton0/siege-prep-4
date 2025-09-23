extends AreaSubComponent
class_name ConveyorAreaSubComponent
func _init() -> void:
	component_id = "ConveyorAreaSub"

@export var convey_amount:Vector2 = Vector2(1, 0)
var motion_components:Array[MotionComponent] = []

func convey(target:Actor, motion:MotionComponent = null):
	if not actor.is_active():
		return
	
	if motion == null:
		for component in target.get_components():
			if component is MotionComponent:
				motion = component
		if motion == null:
			return
	
	if motion.overrider == null or motion.overrider == self:
		if not motion_components.has(motion):
			motion_components.append(motion)
		
		motion.overrider = self
		
		motion.me.velocity = convey_amount.rotated(actor.rotation)

func _process(_delta: float) -> void:
	
	# IF deactivated, get rid of all overrides
	if not actor.is_active():
		for component in motion_components:
			component.overrider = null
			motion_components.erase(component)
			
	
	# Undo the override
	for component in motion_components:
		
		if not is_instance_valid(component):
			# sum'n ain't right. (something was freed)
			# clear the array of invalid components
			var new_motion_components:Array[MotionComponent]
			
			for new_component in motion_components:
				if is_instance_valid(new_component):
					new_motion_components.append(new_component)
			
			motion_components = new_motion_components
			return
		
		
		var object = component
		# IF the motioncomponent isn't overlapping anymore
		if object is CharacterBody2D:
			if not overlapping_bodies.has(component):
				component.overrider = null
				motion_components.erase(component)
				# component = null
		elif object is Area2D:
			if not overlapping_areas.has(component):
				component.overrider = null
				motion_components.erase(component)
				# component = null

func while_colliding_areas(areas:Array[Area2D], _delta:float) -> void:
	for area in areas:
		var a = area
		if a is Component:
			convey(a.actor)
func while_colliding_bodies(bodies:Array[Node2D], _delta:float) -> void:
	for body in bodies:
		var b = body
		if b is Component:
			# Take a shortcut if this already IS
			# the MotionComponent
			if b is MotionComponent:
				convey(b.actor, b)
			convey(b.actor)
