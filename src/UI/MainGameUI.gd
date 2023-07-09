extends Control
class_name MainGameUI


@onready var artistEnergyLabel : Label = $ArtistEnergyLabel
@onready var heroGoldLabel : Label = $HeroGoldLabel
@onready var enemyHolder : EntityHolder = $EnemyHolder
@onready var npcHolder : EntityHolder = $NPCHolder
@onready var itemHolder : ItemHolder = $ItemHolder
@onready var destructionBar  = $DestructionBar



func _ready():
	## This is just to test
	enemyHolder.holdedEntityData = preload("res://src/mainGame/entities/enemies/SlimeEnemyData.tres")
	npcHolder.holdedEntityData = preload("res://src/mainGame/entities/NPCs/Man.tres")
	itemHolder.holdedItemData = preload("res://src/mainGame/items/TestItemData.tres")

func _on_artist_energy_changed(newValue: int) -> void:
	artistEnergyLabel.text = 'My Will To Dev: ' + str(newValue)
	enemyHolder.on_artist_energy_changed(newValue)
	npcHolder.on_artist_energy_changed(newValue)

func _on_hero_gold_changed(newValue: int) -> void:
	heroGoldLabel.text = 'Gold: ' + str(newValue)
	itemHolder._on_hero_gold_changed(newValue)
	Audio._play(load("res://assets/Audio/SFX/Coin.tres"))

func _on_destruction_changed(newValue) -> void:
	destructionBar.value = newValue
