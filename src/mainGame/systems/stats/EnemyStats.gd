class_name EnemyStats


signal died
signal statChanged(stat, newValue)

var bloodLustReduction : int :
	set(newValue):
		bloodLustReduction = clamp(newValue, 0, 99)
		statChanged.emit(Constants.ENEMY_STATS.bloodlustReduction, bloodLustReduction)

var goldReward : int :
	set(newValue):
		goldReward = clamp(newValue, 0, 99)
		statChanged.emit(Constants.ENEMY_STATS.goldReward, goldReward)

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
