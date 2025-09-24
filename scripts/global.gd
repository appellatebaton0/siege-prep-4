extends Node

@warning_ignore("unused_signal") signal play_sfx(sfx:AudioStream)
@warning_ignore("unused_signal") signal new_particle(particle:PackedScene, at:Vector2)

var global_animations:Array[GlobalAnimation]
func add_global_animation(additor:GlobalAnimation):
	if not global_animations.has(additor):
		global_animations.append(additor)

func _process(delta: float) -> void:
	
	for animation in global_animations:
		animation.frame_timer += delta
		
		if animation.frame_timer >= (1 / animation.fps):
			animation.current_frame += 1
			animation.frame_timer = 0.0
			
			if animation.current_frame >= len(animation.frames):
				animation.current_frame = 0
