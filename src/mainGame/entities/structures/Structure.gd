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


func _connectSignals() -> void:
	stats.destroyed.connect(_die)

func _die() -> void:
	queue_free()



