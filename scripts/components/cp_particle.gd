extends Component # Doesn't 
class_name ParticleComponent
func _init() -> void:
	component_id = "Particle"

## The packedscene to spawn when the make function is called
@export var particle:PackedScene
## Whether to summon a particle once ready.
@export var make_on_ready := false
var ready_delay := 0.01

func _process(delta: float) -> void:
	if make_on_ready:
		ready_delay = move_toward(ready_delay, 0, delta)
		if ready_delay <= 0:
			make()
			make_on_ready = false

func make():
	Global.new_particle.emit(particle, actor.global_position)
