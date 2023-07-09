extends CharacterBody2D
class_name Hero


signal heroStartedCombat 
signal heroStoppedCombat
signal heroFoundNPC
signal heroLostNPC

@export_range(0,99) var baseBloodlust : int
@export_range(0,99) var baseDamage : int
@export_range(0,999) var baseHealth : int
@export_range(0,99) var baseDefence : int
@export_range(0,999) var baseGold : int

@onready var attackModule : AttackModule = $AttackModule
@onready var lifeBar : ProgressBar = $Lifebar
@onready var BloodlustBar : ProgressBar = $BloodlustBar

var heroStats := HeroStats.new()

var items : Array[ItemData]

var current_anim:String = "Idle"

var isWithNPC: bool :
	set(newValue):
		isWithNPC = newValue
		if isWithNPC:
			heroFoundNPC.emit()
		else:
			heroLostNPC.emit()

var isInCombat : bool :
	set(newValue):
		isInCombat = newValue
		if isInCombat:
			attackModule.start()
			heroStartedCombat.emit()
		else:
			attackModule.stop()
			heroStoppedCombat.emit()

var enemiesDetected : Array :
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
	heroStats.defence = baseDefence
	
	lifeBar.max_value = baseHealth
	lifeBar.value = heroStats.health
	BloodlustBar.value = heroStats.bloodlust
	
	heroStats.statEmitParticle.connect(emit_stat_particle)
	_connectSignal()

func _connectSignal() -> void:
	heroStats.statChanged.connect(_on_stat_changed)

func emit_stat_particle(type:String, up:bool):
	Particles.play_particles($GPUParticles2D, type, up)

func recieveDamage(damage: int) -> void:
	var dam = clamp(damage - heroStats.defence, 1, 999)
	heroStats.health -= dam
	
	$AnimatedSprite2D.play("Damage")
	$SFX.stream = load("res://assets/Audio/SFX/HeroHit.tres")
	$SFX.play()

func giveDeathReward(bloodlustReduction, gold) -> void:
	heroStats.bloodlust -= bloodlustReduction
	heroStats.gold += gold

func _shouldAttackNPC(npc: NPC) -> bool:
	if heroStats.bloodlust >= npc.stats.murderability:
		return true
	else:
		return false

func _shouldGetReward(npc: NPC) -> bool:
	if heroStats.bloodlust >= npc.stats.desiredGoodness:
		return true
	else:
		return false

func _addItem(itemData) -> void:
	items.append(itemData)
	heroStats.bloodlust += itemData.bonusBloodlust
	heroStats.damage = itemData.bonusDamage
	heroStats.health = itemData.bonusHealth

func _destroyNPC(npc : NPC) -> void:
	owner.destructionLevel += npc.stats.destruction

func _forgiveNPC(npc: NPC) -> void:
	owner.destructionLevel -= npc.stats.goodness

func _on_item_purchased(itemData: ItemData, cost: int) -> void:
	heroStats.gold -= cost
	_addItem(itemData)

func _on_attack_module_do_attack():
	if enemiesDetected.size() == 0:
		return
	var selectedEnemy = enemiesDetected[0]
	selectedEnemy.recieveDamage(heroStats.damage)
	
	$AnimatedSprite2D.play("Attack")
	$SFX.stream = load("res://assets/Audio/SFX/Punch.tres")
	$SFX.play()

func _on_attack_module_area_detected(area):
	if area.owner is Enemy or area.owner is Structure:
		var oldEnemies = enemiesDetected.duplicate()
		oldEnemies.append(area.owner)
		enemiesDetected = oldEnemies
	if area.owner is NPC:
		var npc = area.owner
		isWithNPC = true
		var shouldAttack = _shouldAttackNPC(npc)
		if shouldAttack:
			npc.getsAttacked()
			_destroyNPC(npc)
			isWithNPC = false ## just for now, then later we would need to wait for an animation or dialogue
		else:
			_forgiveNPC(npc)
			isWithNPC = false ## just for now, then later we would need to wait for an animation or dialogue


func _on_attack_module_area_exited(area):
	if area.owner is Enemy or area.owner is Structure:
		var enemy = area.owner
		if enemiesDetected.has(enemy):
			var oldEnemies = enemiesDetected.duplicate()
			oldEnemies.erase(enemy)
			enemiesDetected = oldEnemies

func _on_stat_changed(stat: int, newValue) -> void:
	if stat == Constants.HERO_STATS.health:
		lifeBar.value = newValue
	if stat == Constants.HERO_STATS.bloodlust:
		BloodlustBar.value = newValue


func _on_bloodlust_timer_timeout():
	heroStats.bloodlust += 1

func play_anim(anim:String, left:bool=false):
	$AnimatedSprite2D.play(anim)
	$AnimatedSprite2D.flip_h = left
	
	current_anim = anim
	if anim == "Walk": play_walk_sounds()
	
func play_walk_sounds():
	$SFX.stream = load("res://assets/Audio/SFX/Footsteps.tres")
	while current_anim == "Walk":
		$SFX.play()
		await  $SFX.finished
