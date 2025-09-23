extends Element
class_name TextureRectElement

@export var value:DynamicValue
var me:TextureRect = get_me()

func _ready() -> void:
	_update_texture()

func _update_texture():
	me.texture = value.value()
