class_name HeroStats


signal heroDied
signal statChanged(stat, newValue)
signal statEmitParticle(stat:String, up:bool)
signal goldChanged(newValue)

var bloodlust : int :
	set(newValue): 
		statEmitParticle.emit("bloodlust", (bloodlust < newValue))
		bloodlust = clamp(newValue, 0, 100)
		statChanged.emit(Constants.HERO_STATS.bloodlust, bloodlust)

var damage : int :
	set(newValue):
		statEmitParticle.emit("damage", (damage < newValue))
		damage = clamp(newValue, 0, 99)
		statChanged.emit(Constants.HERO_STATS.damage, damage)

var defence : int :
	set(newValue):
		defence = clamp(newValue,0, 999)
		statChanged.emit(Constants.HERO_STATS.defence, defence)

var health : int :
	set(newValue):
		print('health', health,' ' , newValue)
		statEmitParticle.emit("health", (health < newValue))
		health = clamp(newValue,0, 999)
		statChanged.emit(Constants.HERO_STATS.health, health)
		if health == 0:
			heroDied.emit()

var gold : int :
	set(newValue):
		statEmitParticle.emit("gold", (gold < newValue))
		gold = clamp(newValue, 0, 999)
		statChanged.emit(Constants.HERO_STATS.gold, gold)
		goldChanged.emit(gold)
