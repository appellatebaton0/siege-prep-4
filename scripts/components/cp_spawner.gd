extends Component
class_name SpawnerComponent
var me:Node2D = get_me()
func _init() -> void:
	component_id = "Spawner"

signal spawning

@onready var options_component:OptionsSpawnerComponent
@onready var position_component:PositionSpawnerComponent
@onready var rotation_component:RotationSpawnerComponent
@onready var velocity_component:VelocitySpawnerComponent

## The place newly added objects should go
@export var main:Node
## Alternative option, set the group name to find main in the tree.
@export var main_group:String
## The condition for spawning something. Empty = always true
@export var condition:DynamicCondition

@export var spawn_limit := 0 ## How many actors this spawner can create at maximum (-1 = infinite)
var spawned_so_far := 0
@export var auto_spawn := false ## Whether the spawner automatically starts spawning.
@export var spawn_signal_interval := 1.0 ## How long to wait before sending the "spawning" signal. Must be less than spawn_interval.
var sent_signal := false ## Whether the signal's been sent this go around.
@export var spawn_interval := 1.0 ## How long to wait between each spawn
@export var spawn_time := 0.0 ## The time before the first spawn


func _ready() -> void:
	
	if main_group != null and main_group != "":
		main = get_tree().get_first_node_in_group(main_group)
	
	for child in get_children():
		if child is OptionsSpawnerComponent:
			options_component = child
		elif child is VelocitySpawnerComponent:
			velocity_component = child
		elif child is RotationSpawnerComponent:
			rotation_component = child
		elif child is PositionSpawnerComponent:
			position_component = child
		elif child is DynamicCondition and condition == null:
			condition = child

func get_actor_motion_component(from:Actor) -> MotionComponent:
	for component in from.get_components():
		if component is MotionComponent:
			return component
	return null

func spawn():
	for options in options_component.get_options():
		var new:Actor = options.instantiate()
		
		## Get transform
		var global_position:Vector2 = position_component.get_position() if position_component != null else me.global_position
		var rotation:float   = deg_to_rad(rotation_component.get_rotation()) if rotation_component != null else 0.0
		var velocity:Vector2 = velocity_component.get_velocity() if velocity_component != null else Vector2.ZERO

		main.add_child(new)
		
		# Apply position & rotation
		new.global_position = global_position
		new.rotation = rotation
		
		# Apply initial velocity (or attempt to)
		if get_actor_motion_component(new) != null:
			get_actor_motion_component(new).me.velocity = velocity.rotated(rotation)

func _process(delta: float) -> void:
	if auto_spawn and actor.is_active():
		if condition.value() and (spawned_so_far < spawn_limit or spawn_limit < 0):
			spawn_time = move_toward(spawn_time, spawn_interval, delta)
			
			if spawn_time >= spawn_signal_interval and not sent_signal:
				spawning.emit()
				sent_signal = true
			
			if spawn_time >= spawn_interval:
				spawn()
				spawn_time = 0.0
				sent_signal = false
