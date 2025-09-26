extends MotionState
class_name FuncPlatformerMotionState
func _init():
	component_id = "FuncPlatformerMotionState"

## ALlows for an actor to be controlled like
## a platformer by calling functions.

## How much upwards velocity is applied on a jump.
@export var jump_velocity := 300.0

## How much the actor accelerates on the ground while trying to move, per second.
@export var floor_acceleration := 50.0
## How much the actor accelerates while trying to move, per second.
@export var air_acceleration := 50.0

enum friction_types{
	subtract, ## Subtract the value from the current speed.
	divide ## Divide the current speed by the value
	}

## How much the actor slows down while on the floor, per second.
@export var floor_friction := 15.0
## What kind of friction to use while on the floor
@export var floor_friction_type := friction_types.subtract

## How much the actor slows down while midair, per second.
@export var air_friction := 15.0
## What kind of friction to use while midair
@export var air_friction_type := friction_types.subtract

## The maximum speed the actor can reach through this (other forces can apply more momentum).
@export var max_speed := 100.0
var speed:float = 0.0
## How much gravity affects the actor.
@export var gravity_multiplier := 1.0

@export var is_moving:bool = false ## The toggle for if the actor *should* be moving.
var facing_left:bool = false ## The direction the actor is moving

var should_move:bool = false ## Whether to actually move this frame.
var should_jump:bool = true ## Logs if a jump was ordered.

func start_moving(): # Toggle on moving
	is_moving = true

func stop_moving(): # Toggle off moving
	is_moving = false

func move(): # Move for one frame
	should_move = true

func turn_around(): # ...Self explanatory
	facing_left = not facing_left

func jump():
	should_jump = true

func phys_active(delta:float):
	if character.is_on_floor():
		component.substate = "Walking" if character.velocity.x != 0 else "Idle"
	else:
		component.substate = "Midair"
	
	if not character.is_on_floor():
		character.velocity += delta * character.get_gravity() * gravity_multiplier
	
	if is_moving:
		should_move = true
	
	if should_jump:
		if character.is_on_floor() and should_move:
			character.velocity.y = min(character.velocity.y, -jump_velocity)
	should_jump = false
	
	var current_friction := floor_friction if character.is_on_floor() else air_friction
	if should_move:
		var direction := -1 if facing_left else 1
	
		# Set acceleration and friction.
		var current_acceleration := floor_acceleration if character.is_on_floor() else air_acceleration
		if direction:
			# If the actor isn't already moving faster
			if not abs(character.velocity.x) > max_speed:
				character.velocity.x = move_toward(character.velocity.x, direction * max_speed, delta * current_acceleration)
			
		# Friction! Move towards 0 based on the current friction.
			else:
				character.velocity.x = move_toward(character.velocity.x, 0, delta * current_friction)
		else:
			character.velocity.x = move_toward(character.velocity.x, 0, delta * current_friction)
		should_move = false
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, delta * current_friction)
