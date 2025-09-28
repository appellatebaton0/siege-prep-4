class_name StaticComponent extends Component
var me:StaticBody2D = get_me()
func _init():
	component_id = "Static"

@onready var layer = me.collision_layer
@onready var mask = me.collision_mask

func _process(_delta: float) -> void:
	if not actor.is_active() and me.collision_layer != 0:
		me.collision_layer = 0
		me.collision_mask = 0
	elif actor.is_active() and me.collision_layer == 0:
		me.collision_layer = layer
		me.collision_mask = mask
