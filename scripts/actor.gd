class_name Actor extends Node2D

signal freeing

# A class for Node2Ds that allows them to adopt
# functionality from Components.

# See also: Interface for Controls -> Elements

@export var static_texture:Texture

var active_lockers:Array[Node]
func add_active_lock(node:Node) -> bool:
	if not active_lockers.has(node):
		active_lockers.append(node)
		return true
	return false
func remove_active_lock(node:Node) -> bool:
	if active_lockers.has(node):
		active_lockers.erase(node)
		return true
	return false
func is_active() -> bool:
	return len(active_lockers) == 0

func late_free():
	freeing.emit()
	call_deferred("queue_free")

@onready var components:Array[Component] = get_components()

# Get components
func get_components(depth:int = 4, with:Node = self) -> Array[Component]:
	if depth <= 0:
		return []
	
	var return_components:Array[Component]
		
	for child in with.get_children():
		if child is Component:
			return_components.append(child)
		return_components.append_array(get_components(depth - 1, child))
	
	return return_components

func get_actors(depth:int = 4, with:Node = self) -> Array[Actor]:
	if depth <= 0:
		return []
	
	var return_actors:Array[Actor]
	
	for child in with.get_children():
		if child is Actor:
			return_actors.append(child)
		return_actors.append_array(get_components(depth - 1, child))
	
	return return_actors
	
	# etc etc.

func _init() -> void:
	
	# If a static_texture isn't specified, try
	# to find a Sprite2D to grab one from.
	if static_texture == null:
		for child in get_children():
			if child is Sprite2D:
				static_texture = child.texture
