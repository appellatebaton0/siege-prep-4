extends Node
class_name ParticleManager

@export var add_to:DynamicNodeValue

var particles:Array[GPUParticles2D]

func _ready() -> void:
	Global.new_particle.connect(_on_new_particle)

func _on_new_particle(particle:PackedScene, at:Vector2):
	var new:GPUParticles2D = particle.instantiate()
	
	if main != null:
		main.value().add_child(new)
	else:
		add_child(new)
	new.global_position = at
	new.emitting = true
	new.z_index = 4
	
	particles.append(new)

func _process(_delta: float) -> void:
	for particle in particles:
		if not particle.emitting:
			particle.queue_free()
			
			particles.erase(particle)
