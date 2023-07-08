extends Control
class_name MainGameUI


@onready var artistEnergyLabel : Label = $ArtistEnergyLabel
@onready var enemyHolder : EntityHolder = $EnemyHolder
@onready var npcHolder : EntityHolder = $NPCHolder


func _ready():
	## This is just to test
	enemyHolder.holdedEntityData = preload("res://src/mainGame/entities/enemies/TestEnemyData.tres")
	npcHolder.holdedEntityData = preload("res://src/mainGame/entities/NPCs/TestNPCData.tres")

func _on_artist_energy_changed(newValue: int) -> void:
	artistEnergyLabel.text = 'Energy: ' + str(newValue)
	enemyHolder.on_artist_energy_changed(newValue)
	npcHolder.on_artist_energy_changed(newValue)
