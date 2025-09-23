extends Component # Doesn't 
class_name ParticleComponent
func _init() -> void:
	component_id = "Particle"

@export var particle:PackedScene
@export var play_on_free:bool = false

func _ready() -> void:
	if play_on_free:
		actor.freeing.connect(make)

func make():
	Global.new_particle.emit(particle, actor.global_position)
