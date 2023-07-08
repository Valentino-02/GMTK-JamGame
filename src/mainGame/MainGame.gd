extends Node2D
class_name MainGame


signal confirmEntityDrop
signal destructionLevelChanged(newValue)

@onready var artist : Artist = $Artist
@onready var enemyHolder = $EnemyHolder

var destructionLevel : int : 
	set(newValue):
		destructionLevel = clamp(newValue, 0, 999)
		destructionLevelChanged.emit(destructionLevel)


func _ready():
	## This is just to test, will delete later
	var enemy = ScenesPaths.Enemy.instantiate()
	addEnemy(enemy, Vector2(200,200) )
	
	_connectSignals()


func createEnemy(enemyData: EnemyData) -> Enemy:
	var enemy = ScenesPaths.Enemy.instantiate()
	enemy.enemyData = enemyData
	return enemy

func addEnemy(enemy: Enemy, position: Vector2 = Vector2(0,0)) -> void:
	enemy.erased.connect(artist._on_enemy_erased)
	artist.energyChanged.connect(enemy._on_artist_energy_changed)
	enemy.position = position
	enemyHolder.add_child(enemy)


func _connectSignals() -> void:
	var gameUI = GlobalScenes.CurrentUI
	if gameUI is MainGameUI:
		artist.energyChanged.connect(gameUI._on_artist_energy_changed)
		
		gameUI.enemyHolder.askCanDropHere.connect(_on_ask_can_drop_here)
		confirmEntityDrop.connect(gameUI.enemyHolder._on_drop_confirmation)


func _on_ask_can_drop_here(position: Vector2, entityData: Resource) -> void:
	## this is just for now, later we will need to chek if it can be placed here
	if entityData is EnemyData:
		artist.energy -= entityData.deployCost
		var enemy = createEnemy(entityData)
		addEnemy(enemy, position)
		confirmEntityDrop.emit()
	
