class_name StructureStats


signal statChanged(stat, newValue)
signal destroyed

var health: int:
	set(newValue):
		health = clamp(newValue, 0, 999)
		statChanged.emit(Constants.STRUCTURE_STATS.health, health)
		if health == 0:
			destroyed.emit()

var destructability: int :
	set(newValue):
		destructability = clamp(newValue, 0, 99)
		statChanged.emit(Constants.STRUCTURE_STATS.destructability, destructability)

