extends Component
class_name AnimatedSpriteComponent
var me:AnimatedSprite2D = get_me()

func _init() -> void:
	component_id = "AnimatedSprite"

## If set, plays a global animation that synces across nodes with it.
@export var global_animation:GlobalAnimation
## If set, the actor's motion substate will affect the animation to play.
## Key: Substate, Value: AnimationName
@export var motion_ties:Dictionary[String, String]
var motion_component:MotionComponent

func _ready():
	if motion_ties != null:
		for component in actor.get_components():
			if component is MotionComponent:
				motion_component = component
	
	if global_animation != null:
		Global.add_global_animation(global_animation)

func _process(_delta: float) -> void:
	if global_animation != null:
		me.frame = global_animation.current_frame
	if motion_ties != null and motion_component != null:
		if motion_component.me.velocity.x != 0:
			me.flip_h = motion_component.me.velocity.x < 0
		for tie in motion_ties:
			if motion_component.substate == tie:
				if me.sprite_frames.has_animation(motion_ties[tie]):
					me.play(motion_ties[tie])
