class_name NPC_Stats


signal statChanged(stat, newValue)
signal destroyed

var goodness: int:
	set(newValue):
		goodness = clamp(newValue, 0, 999)
		statChanged.emit(Constants.NPC_STATS.goodness, goodness)

var destruction: int:
	set(newValue):
		destruction = clamp(newValue, 0, 999)
		statChanged.emit(Constants.NPC_STATS.destruction, destruction)

var murderability: int :
	set(newValue):
		murderability = clamp(newValue, 0, 99)
		statChanged.emit(Constants.NPC_STATS.murderability, murderability)
