extends Node
class_name Artist


signal energyChanged(newValue)

@export_range(0,999) var startingEnergy : int
@export_range(0,99) var energyPerSecond : int

var energy: int :
	set(newValue) :
		energy = clamp(newValue, 0, 999)
		energyChanged.emit(energy)
		print(newValue)


func _ready():
	energy = startingEnergy


func _on_enemy_erased(cost) -> void:
	energy -= cost

func _on_energy_timer_timeout():
	energy += energyPerSecond
