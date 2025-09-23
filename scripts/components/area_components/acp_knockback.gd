extends AreaSubComponent
class_name KnockbackAreaSubComponent
func _init() -> void:
	component_id = "KnockbackAreaSub"

@export var amount:float = 0.0
@export var cooldown:float = 0.0
var cooldown_left:float = 0.0

func _process(delta: float) -> void:
	cooldown_left = move_toward(cooldown_left, 0, delta)

func apply_to(component:MotionComponent):
	component.me.velocity += amount * actor.global_position.direction_to(component.actor.global_position)

func on_body_entered(body: Node2D) -> void:
	if cooldown_left <= 0:
		var component = body
		if component is MotionComponent:
			apply_to(component)
			cooldown_left = cooldown
