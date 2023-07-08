class_name HeroStats


signal heroDied
signal statChanged(stat, newValue)

var bloodlust : int :
	set(newValue): 
		bloodlust = clamp(newValue, 0, 99)
		statChanged.emit(Constants.HERO_STATS.bloodlust, bloodlust)

var damage : int :
	set(newValue):
		damage = clamp(newValue, 0, 99)
		statChanged.emit(Constants.HERO_STATS.damage, damage)

var health : int :
	set(newValue):
		health = clamp(newValue,0, 999)
		statChanged.emit(Constants.HERO_STATS.health, health)
		if health == 0:
			heroDied.emit()

var gold : int :
	set(newValue):
		gold = clamp(newValue, 0, 999)
		statChanged.emit(Constants.HERO_STATS.gold, gold)
