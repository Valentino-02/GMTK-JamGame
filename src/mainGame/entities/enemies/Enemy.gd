extends Node2D
class_name Enemy


signal erased(cost)

@export var enemyData: EnemyData

@onready var animatedSprite = $AnimatedSprite2D
@onready var eraseButtonCross = $EraseButton/Cross

var stats := EnemyStats.new()

var canErase : bool : 
	set(newValue):
		canErase = newValue
		if canErase == true:
			eraseButtonCross.modulate = Color(1,1,1,1)
		if canErase == false:
			eraseButtonCross.modulate = Color(1,1,1,0.5)


func _ready():
	stats.health = enemyData.baseHealth
	stats.damage = enemyData.baseDamage
	stats.bravery = enemyData.baseBravery
	
	_connectSignals()


func recieveDamage(damage: int) -> void:
	stats.health -= damage


func _connectSignals() -> void:
	stats.died.connect(_die)

func _erase() -> void:
	queue_free()
	erased.emit(enemyData.eraseCost)

func _die() -> void:
	queue_free()


func _on_artist_energy_changed(newValue) -> void:
	canErase = newValue >= enemyData.eraseCost

func _on_erase_button_pressed():
	if not canErase: 
		return
	_erase()

