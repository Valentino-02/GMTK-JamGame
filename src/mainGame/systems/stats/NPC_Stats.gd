class_name NPC_Stats


signal statChanged(stat, newValue)
signal destroyed

var desiredGoodness: int:
	set(newValue):
		desiredGoodness = clamp(newValue, 0, 999)
		statChanged.emit(Constants.NPC_STATS.desiredGoodness, desiredGoodness)


var murderability: int :
	set(newValue):
		murderability = clamp(newValue, 0, 99)
		statChanged.emit(Constants.NPC_STATS.murderability, murderability)
