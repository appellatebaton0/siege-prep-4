class_name Camera extends Camera2D

@export var speed := 1

func _process(_delta: float) -> void:
	if Input.is_action_pressed("Down"):
		global_position.y += speed
	if Input.is_action_pressed("Up"):
		global_position.y -= speed
	if Input.is_action_pressed("Left"):
		global_position.x -= speed
	if Input.is_action_pressed("Right"):
		global_position.x += speed
