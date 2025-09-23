extends Component
class_name AnimatedSpriteComponent
var me:AnimatedSprite2D = get_me()

func _init() -> void:
	component_id = "AnimatedSprite"

@export var global_animation:GlobalAnimation

func _ready():
	if global_animation != null:
		Global.add_global_animation(global_animation)

func _process(_delta: float) -> void:
	if global_animation != null:
		me.frame = global_animation.current_frame
