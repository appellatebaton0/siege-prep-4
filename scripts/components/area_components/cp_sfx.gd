extends Component
class_name SFXComponent
func _init() -> void:
	component_id = "SFX"

@export var sfx:AudioStream
@export var play_on_free:bool = false

func _ready() -> void:
	if play_on_free:
		actor.freeing.connect(make)

func make():
	Global.play_sfx.emit(sfx)
