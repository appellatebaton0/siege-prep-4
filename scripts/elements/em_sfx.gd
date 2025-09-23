extends Element
class_name SFXElement

@export var sfx:AudioStream

func make():
	Global.play_sfx.emit(sfx)
