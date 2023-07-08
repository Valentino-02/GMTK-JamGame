extends Node2D
class_name NPC


signal erased(cost)

@export var npcData: NPCData

@onready var animatedSprite = $AnimatedSprite2D
@onready var eraseButtonCross = $EraseButton/Cross

var stats := NPC_Stats.new()

var canErase : bool : 
	set(newValue):
		canErase = newValue
		if canErase == true:
			eraseButtonCross.modulate = Color(1,1,1,1)
		if canErase == false:
			eraseButtonCross.modulate = Color(1,1,1,0.5)


func _ready():
	stats.murderability = npcData.baseMuerderability
	stats.desiredGoodness = npcData.baseDesiredGoodness
	
	_connectSignals()


func getsAttacked() -> void:
	pass
	_die()

func givesReward() -> void:
	_die()


func _connectSignals() -> void:
	pass

func _erase() -> void:
	queue_free()
	erased.emit(npcData.eraseCost)

func _die() -> void:
	queue_free()


func _on_artist_energy_changed(newValue) -> void:
	canErase = newValue >= npcData.eraseCost

func _on_erase_button_pressed():
	if not canErase: 
		return
	_erase()
