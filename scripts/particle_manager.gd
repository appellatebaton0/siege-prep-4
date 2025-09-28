extends Node
class_name ParticleManager

@export var add_to:DynamicNodeValue

var particles:Array[GPUParticles2D]

func _ready() -> void:
	# Get the add_to from children
	if add_to == null:
		for child in get_children():
			if child is DynamicNodeValue:
				add_to = child
				break
	
	Global.new_particle.connect(_on_new_particle)

func _on_new_particle(particle:PackedScene, at:Vector2):
	var new:GPUParticles2D = particle.instantiate()
	
	if add_to != null:
		add_to.value().add_child(new)
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
