extends Node2D
class_name MainGame


signal confirmEntityDrop
signal destructionLevelChanged(newValue)
signal nextInteraction
signal nextMonolog

@onready var artist : Artist = $Artist
@onready var enemyHolder = $EnemyHolder
@onready var npcHolder = $EnemyHolder
@onready var structureHolder = $StructureHolder
@onready var hero : Hero = $Hero

var destructionLevel : int : 
	set(newValue):
		destructionLevel = clamp(newValue, 0, 999)
		destructionLevelChanged.emit(destructionLevel)


func _ready():
	_connectSignals()


func createEnemy(enemyData: EnemyData) -> Enemy:
	var enemy = ScenesPaths.Enemy.instantiate()
	enemy.enemyData = enemyData
	return enemy

func createNPC(npcData: NPCData) -> NPC:
	var npc = ScenesPaths.NPC.instantiate()
	npc.npcData = npcData
	return npc

func addEntity(entity, position: Vector2) -> void:
	entity.erased.connect(artist._on_enemy_erased)
	artist.energyChanged.connect(entity._on_artist_energy_changed)
	entity.position = position
	if entity is Enemy:
		enemyHolder.add_child(entity)
	if entity is NPC:
		npcHolder.add_child(entity)


func _connectSignals() -> void:
	var gameUI = GlobalScenes.CurrentUI
	if gameUI is MainGameUI:
		artist.energyChanged.connect(gameUI._on_artist_energy_changed)
		
		gameUI.enemyHolder.askCanDropHere.connect(_on_ask_can_drop_here)
		gameUI.npcHolder.askCanDropHere.connect(_on_ask_can_drop_here)
		confirmEntityDrop.connect(gameUI.enemyHolder._on_drop_confirmation)
		confirmEntityDrop.connect(gameUI.npcHolder._on_drop_confirmation)
		
		hero.heroStats.goldChanged.connect(gameUI._on_hero_gold_changed)
		gameUI.itemHolder.itemPurchased.connect(hero._on_item_purchased)


func _on_ask_can_drop_here(position: Vector2, entityData: Resource) -> void:
	## this is just for now, later we will need to chek if it can be placed here
	if entityData is EnemyData:
		artist.energy -= entityData.deployCost
		var enemy = createEnemy(entityData)
		addEntity(enemy, position)
		confirmEntityDrop.emit()
	if entityData is NPCData:
		artist.energy -= entityData.deployCost
		var npc = createNPC(entityData)
		addEntity(npc, position)
		confirmEntityDrop.emit()
