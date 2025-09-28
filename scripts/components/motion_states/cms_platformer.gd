class_name PlatformerControlMotionState extends ControlMotionState

## Allows the actor to be controlled like a platformer.

## How long the jump input will save, so you can hit jump before being on the ground and still jump (in seconds).
@export var jump_buffering := 0.1
var jump_buffer := 0.0 # The current jump buffer
## How long the on_floor will save, so you can jump for a bit after leaving the ground (in seconds).
@export var coyote_jump_buffer := 0.1
var coyote_buffer := 0.0 # The current coyote jump buffer

## How much upwards velocity is applied on a jump.
@export var jump_velocity := 300.0

## How much the actor accelerates on the ground while trying to move, per second.
@export var floor_acceleration := 15.0
## How much the actor accelerates while trying to move, per second.
@export var air_acceleration := 15.0

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

func phys_active(delta:float):
	
	## Gravity
	
	if not character.is_on_floor():
		character.velocity += delta * character.get_gravity() * gravity_multiplier
	## Jumping
	
	
	# Jump buffering
	jump_buffer = move_toward(jump_buffer, 0, delta)
	if Input.is_action_just_pressed(input_up):
		jump_buffer = jump_buffering
	
	# Coyote jumping
	coyote_buffer = move_toward(coyote_buffer, 0, delta)
	if character.is_on_floor():
		coyote_buffer = coyote_jump_buffer
	
	# Jumping
	if jump_buffer > 0 and coyote_buffer > 0:
		character.velocity.y = min(character.velocity.y, -jump_velocity)
		# Reset the buffers to prevent double jumping
		coyote_buffer = 0
		jump_buffer = 0
	
	## Movement
	var direction := Input.get_axis(input_left, input_right)
	
	# Set acceleration and friction.
	var current_acceleration := floor_acceleration if character.is_on_floor() else air_acceleration
	var current_friction := floor_friction if character.is_on_floor() else air_friction
	if direction:
		# If the actor isn't already moving faster
		if not abs(character.velocity.x) > max_speed:
			character.velocity.x = move_toward(character.velocity.x, direction * max_speed, delta * current_acceleration)
		
	# Friction! Move towards 0 based on the current friction.
		else:
			character.velocity.x = move_toward(character.velocity.x, 0, delta * current_friction)
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, delta * current_friction)
