extends Node2D
class_name Structure


@export var structureData: StructureData

@onready var animatedSprite = $AnimatedSprite2D
@onready var eraseButtonCross = $EraseButton/Cross

var stats := StructureStats.new()


func _ready():
	stats.health = structureData.baseHealth
	stats.destructability = structureData.baseDestructability
	
	_connectSignals()


func recieveDamage(damage: int) -> void:
	stats.health -= damage
	Particles.play_particles($GPUParticles2D, "health", false)


func _connectSignals() -> void:
	stats.destroyed.connect(_die)

func _die() -> void:
	Particles.play_death_particles($GPUParticles2D)
	await get_tree().create_timer($GPUParticles2D.lifetime).timeout
	queue_free()



