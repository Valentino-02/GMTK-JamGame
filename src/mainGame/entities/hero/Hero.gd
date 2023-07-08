extends CharacterBody2D
class_name Hero


@export_range(0,99) var baseBloodlust : int
@export_range(0,99) var baseDamage : int
@export_range(0,999) var baseHealth : int
@export_range(0,999) var baseGold : int

@onready var attackModule : AttackModule = $AttackModule

var heroStats := HeroStats.new()
var isInCombat : bool :
	set(newValue):
		print(newValue)
		isInCombat = newValue
		if isInCombat:
			attackModule.start()
		else:
			attackModule.stop()

var enemiesDetected : Array[Enemy] :
	set(newValue):
		enemiesDetected = newValue
		if enemiesDetected.size() == 0:
			isInCombat = false
		else:
			isInCombat = true


func _ready():
	heroStats.bloodlust = baseBloodlust
	heroStats.damage = baseDamage
	heroStats.health = baseHealth
	heroStats.gold = baseGold
	
	heroStats.statEmitParticle.connect(emit_stat_particle)

func emit_stat_particle(type:String, up:bool):
	Particles.play_particles($GPUParticles2D, type, up)

func _process(delta):
	## just for testing
	velocity = Vector2(1,0) * 20
	move_and_slide()


func _on_attack_module_do_attack():
	if enemiesDetected.size() == 0:
		return
	var selectedEnemy = enemiesDetected[0]
	selectedEnemy.recieveDamage(heroStats.damage)

func _on_attack_module_area_detected(area):
	if area.owner is Enemy:
		var oldEnemies = enemiesDetected.duplicate()
		oldEnemies.append(area.owner)
		enemiesDetected = oldEnemies

func _on_attack_module_area_exited(area):
	if area.owner is Enemy:
		var enemy = area.owner
		if enemiesDetected.has(enemy):
			var oldEnemies = enemiesDetected.duplicate()
			oldEnemies.erase(enemy)
			enemiesDetected = oldEnemies
