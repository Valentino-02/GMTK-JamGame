extends Node2D
class_name AttackModule


signal doAttack
signal areaDetected(area)
signal areaExited(area)

@export_range(0,5) var attackCooldown : float

@onready var attackTimer = $AttackTimer

var isOn : bool


func _ready():
	attackTimer.wait_time = attackCooldown


func start() -> void:
	if isOn: return
	attackTimer.start()
	isOn = true

func stop() -> void:
	if not isOn: return
	attackTimer.stop()
	isOn = false


func _on_attack_timer_timeout():
	doAttack.emit()

func _on_area_2d_area_entered(area):
	areaDetected.emit(area)

func _on_area_2d_area_exited(area):
	areaExited.emit(area)
