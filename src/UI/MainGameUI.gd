extends Control
class_name MainGameUI


@onready var artistEnergyLabel : Label = $ArtistEnergyLabel
@onready var heroGoldLabel : Label = $HeroGoldLabel
@onready var enemyHolder : EntityHolder = $EnemyHolder
@onready var npcHolder : EntityHolder = $NPCHolder
@onready var itemHolder : ItemHolder = $ItemHolder
@onready var destructionBar : ProgressBar = $DestructionBar



func _ready():
	## This is just to test
	enemyHolder.holdedEntityData = preload("res://src/mainGame/entities/enemies/TestEnemyData.tres")
	npcHolder.holdedEntityData = preload("res://src/mainGame/entities/NPCs/TestNPCData.tres")
	itemHolder.holdedItemData = preload("res://src/mainGame/items/TestItemData.tres")

func _on_artist_energy_changed(newValue: int) -> void:
	artistEnergyLabel.text = 'Energy: ' + str(newValue)
	enemyHolder.on_artist_energy_changed(newValue)
	npcHolder.on_artist_energy_changed(newValue)

func _on_hero_gold_changed(newValue: int) -> void:
	heroGoldLabel.text = 'Gold: ' + str(newValue)
	itemHolder._on_hero_gold_changed(newValue)

func _on_destruction_changed(newValue) -> void:
	destructionBar.value = newValue
