extends PositionSpawnerComponent
class_name RectPositionSpawnerComponent

@onready var me:CollisionShape2D = get_me()


# In this case, return a random position within the collisionrect
func get_position():
	var x_offset:float = randf_range(-me.shape.size.x, me.shape.size.x) / 2
	var y_offset:float = randf_range(-me.shape.size.y, me.shape.size.y) / 2
	
	return me.global_position + Vector2(x_offset, y_offset)
