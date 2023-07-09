extends Node2D
class_name Enemy


signal erased(cost)

@export var enemyData : EnemyData

@onready var attackModule : AttackModule = $AttackModule
@onready var animatedSprite = $AnimatedSprite2D
@onready var eraseButtonCross = $EraseButton/Cross

var stats := EnemyStats.new()
var hero : Hero
var isAttacking : bool = false

var canErase : bool : 
	set(newValue):
		canErase = newValue
		if canErase == true:
			eraseButtonCross.modulate = Color(1,1,1,1)
		if canErase == false:
			eraseButtonCross.modulate = Color(1,1,1,0.5)


func _ready():
	stats.health = enemyData.baseHealth
	stats.damage = enemyData.baseDamage
	stats.bloodLustReduction = enemyData.bloodlustReduction
	stats.goldReward = enemyData.goldReward
	
	$AnimatedSprite2D.play(enemyData.name+" Idle")
	
	_connectSignals()



func recieveDamage(damage: int) -> void:
	stats.health -= damage
	Particles.play_particles($GPUParticles2D, "health", false)


func _connectSignals() -> void:
	stats.died.connect(_die)

func _erase() -> void:
	Particles.play_death_particles($GPUParticles2D)
	await get_tree().create_timer($GPUParticles2D.lifetime).timeout
	GlobalScenes.CurrentMainScene.nextInteraction.emit()
	erased.emit(enemyData.eraseCost)
	queue_free()

func _die() -> void:
	Particles.play_death_particles($GPUParticles2D)
	await get_tree().create_timer($GPUParticles2D.lifetime).timeout
	hero = GlobalScenes.hero
	hero.giveDeathReward(stats.bloodLustReduction, stats.goldReward)
	GlobalScenes.CurrentMainScene.nextInteraction.emit()
	queue_free()


func _on_artist_energy_changed(newValue) -> void:
	canErase = newValue >= enemyData.eraseCost

func _on_erase_button_pressed():
	if not canErase: 
		return
	$%ClickParticles.emitting = true
	_erase()

func _on_attack_module_area_detected(area):
	if area.owner is Hero and not isAttacking:
		isAttacking = true
		hero = area.owner
		attackModule.start()

func _on_attack_module_do_attack():
	hero.recieveDamage(stats.damage)
	
	$AnimatedSprite2D.play(enemyData.name+" Attack")
