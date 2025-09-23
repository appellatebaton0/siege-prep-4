extends Node
class_name SFX_Manager

const MAX_CONCURRENT_STREAMS:int = 10

var sfx_players:Array[AudioStreamPlayer]

func _ready() -> void:
	Global.play_sfx.connect(_on_play_sfx)

func _on_play_sfx(sfx:AudioStream):
	
	for player in sfx_players:
		
		# If there's an empty one, use that.
		if not player.playing:
			player.stream = sfx
			player.play()
			
			return
	
	# If no empty one was found, try to make a new one.
	if len(sfx_players) < MAX_CONCURRENT_STREAMS:
		var new:AudioStreamPlayer = AudioStreamPlayer.new()
		
		add_child(new)
		new.bus = "SFX"
		new.stream = sfx
		new.play()
