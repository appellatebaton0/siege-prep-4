extends Component
class_name RespawnComponent
var me:Node2D = get_me()

signal respawned

@export var global_lose:bool = false

@onready var spawn_position = actor.global_position

func respawn():
	actor.global_position = spawn_position
	respawned.emit()
	
	if global_lose:
		Global.game_lost.emit()
