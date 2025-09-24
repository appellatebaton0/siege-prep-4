class_name Camera extends Camera2D

## The node to follow.
@export var target:DynamicNodeValue

## How fast to follow the target, 0 = not at all, 1 = instant.
@export var follow_lerp := 0.4
## How far to follow ahead based on the target's momentum, if it has such a thing.
@export var follow_ahead := Vector2.ZERO
var character:CharacterBody2D

enum lock_options{x,y,x_and_y,none}
@export var lock_axis := lock_options.none

func _ready() -> void:
	if target == null:
		for child in get_children():
			if child is DynamicNodeValue:
				target = child
				break

func _process(_delta: float) -> void:
	if target != null:
		var node := target.value()
		
		# Get the characterbody2d if there is one and it's needed
		if follow_ahead != Vector2.ZERO and character == null:
			if node is CharacterBody2D:
				character = node
			elif node is Actor:
				for component in node.get_components():
					if component is CharacterBody2D:
						character = component
		
		
		var target_position = lerp(global_position, node.global_position, follow_lerp)
		
		if follow_ahead != Vector2.ZERO and character != null:
			target_position += follow_ahead * character.velocity / 100
		
		match lock_axis:
			lock_options.x:
				target_position.x = global_position.x
			lock_options.y:
				target_position.y = global_position.y
			lock_options.x_and_y:
				target_position.x = global_position.x
				target_position.y = global_position.y
		
		global_position = target_position
