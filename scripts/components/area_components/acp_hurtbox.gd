extends AreaSubComponent
class_name HurtboxAreaSubComponent
var me:Area2D = get_me()
func _init() -> void:
	component_id = "HurtboxAreaSub"

signal got_hurt
signal clicked_on

@export var clickable:bool = false

func hurt(hurter:Actor):
	got_hurt.emit()


func on_area_entered(area: Area2D) -> void:
	var component = area # Abstract type
	if component is HitboxAreaSubComponent:
		hurt(component.actor)


func on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if clickable:
		if event is InputEventMouseButton:
			if event.pressed:
				clicked_on.emit()
