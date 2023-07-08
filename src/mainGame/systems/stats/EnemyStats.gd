class_name EnemyStats


signal died
signal statChanged(stat, newValue)

var bravery : int :
	set(newValue):
		bravery = clamp(newValue, 0, 99)
		statChanged.emit(Constants.ENEMY_STATS.bravery, bravery)

var damage : int :
	set(newValue):
		damage = clamp(newValue, 0, 99)
		statChanged.emit(Constants.ENEMY_STATS.damage, damage)

var health : int :
	set(newValue):
		health = clamp(newValue, 0, 999)
		statChanged.emit(Constants.ENEMY_STATS.health, health)
		if health == 0:
			died.emit()
