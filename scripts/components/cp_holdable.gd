extends Component
class_name HoldableComponent
func _init() -> void:
	component_id = "Holdable"

## Whether or not to lock to a grid when dropped
@export var grid_locked:bool = false

## The size of each grid cell
@export var grid_size:Vector2 = Vector2(16,16)
## The offset of the grid
@export var grid_offset:Vector2 = Vector2(0,0)

@export var placement_visibility_limits = {
	"x": Vector2(-256,112),
	"y": Vector2(-76,128)
}

## A sprite2D to show where the actor will be placed
@export var placement_indicator:Sprite2D
## A AreaComponent to check if where the actor will
## be placed already has something there.
@export var placement_checker:AreaComponent

## Whether or not holding this actor stops it from being active
@export var makes_inactive:bool = true

@onready var original_z_index = actor.z_index

func _ready() -> void:
	if placement_indicator != null:
		placement_indicator.visible = grid_locked
	if placement_checker != null:
		placement_checker.actor = actor

var held:bool = false
var held_by:HolderComponent

func hold_by(holder:HolderComponent) -> bool:
	
	held_by = holder
	
	# Try to pick up/set down.
	held = holder.hold(actor)
	
	# If it was placed and it shouldn't have been
	# Pick it right back up again
	if placement_checker != null:
		if not held and placement_checker.has_overlapping_collisions():
			held = holder.hold(actor)
	
	
	# Handle making the actor inactive while held
	if makes_inactive:
		if held:
			actor.add_active_lock(self)
		else:
			actor.remove_active_lock(self)
	
	return held

func _process(delta: float) -> void:
	
	if placement_checker != null:
		placement_checker.me.rotation = actor.rotation
	if placement_indicator != null:
		placement_indicator.rotation = actor.rotation
	
	
	# Raise the z_index while held
	actor.z_index = original_z_index + 3 if held else original_z_index

	# Position the placement_indicator and checker
	var round_position = round(((actor.global_position - grid_offset) / grid_size)) * grid_size + grid_offset
	if placement_indicator != null and grid_locked:
		
		placement_indicator.global_position = round_position
		var in_x_bounds = (placement_indicator.global_position.x > placement_visibility_limits["x"].x and placement_indicator.global_position.x < placement_visibility_limits["x"].y)
		var in_y_bounds = (placement_indicator.global_position.y > placement_visibility_limits["y"].x and placement_indicator.global_position.y < placement_visibility_limits["y"].y)
		placement_indicator.modulate.a = move_toward(placement_indicator.modulate.a, 1 if actor.visible and in_x_bounds and in_y_bounds and held else 0, delta * 10)
	if placement_checker != null:
		if grid_locked:
			placement_checker.me.global_position = round_position
		else:
			placement_checker.me.global_position = actor.global_position
	
	if not held and grid_locked: # If the placement failed their position should be locked to a grid
		# Round the actor's position to the grid
		actor.global_position = round_position
