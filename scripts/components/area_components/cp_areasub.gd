@abstract
class_name AreaSubComponent extends Component

@export_flags_2d_physics var collision_mask
@onready var area_component:AreaComponent = get_parent()

# Upkept by the AreaComponent, note objects overlapping with this one. 
var overlapping_areas:Array[Area2D]
var overlapping_bodies:Array[Node2D]

func get_collisions() -> Array[Node2D]:
	var collisions = overlapping_bodies.duplicate()
	collisions.append_array(overlapping_areas.duplicate())
	return collisions

func has_collisions():
	return len(overlapping_areas) > 0 or len(overlapping_bodies) > 0

# All the functions called by the AreaComponent, for use
# by AreaSubComponents

func on_area_entered(_area:Area2D) -> void:
	pass
func on_body_entered(_body:Node2D) -> void:
	pass

func while_colliding_areas(_areas:Array[Area2D], _delta:float) -> void:
	pass
func while_colliding_bodies(_bodies:Array[Node2D], _delta:float) -> void:
	pass

func while_no_colliding_areas(_delta:float) -> void:
	pass
func while_no_colliding_bodies(_delta:float) -> void:
	pass

func while_no_collisions(_delta:float) -> void:
	pass
func while_any_collisions(_delta:float) -> void:
	pass

func on_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	pass
