extends Component
class_name LoseComponent

## Allows signals to be fed in to end the game, and for functions to be run when the game ends.
## Connect signals to lose() to lose the game with them
## Connect game_lost to functions to make them run when the game is lost.

signal game_lost

func _ready() -> void:
	Global.game_lost.connect(_on_game_lost)

func _on_game_lost():
	game_lost.emit()

func lose():
	game_lost.emit()
	print("lose")
	Global.game_lost.emit()
