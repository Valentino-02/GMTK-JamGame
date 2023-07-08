extends CharacterBody2D
class_name Hero


signal heroStartedCombat 
signal heroStoppedCombat
signal heroFoundNPC
signal heroLostNPC

@export_range(0,99) var baseBloodlust : int
@export_range(0,99) var baseDamage : int
@export_range(0,999) var baseHealth : int
@export_range(0,999) var baseGold : int

@onready var attackModule : AttackModule = $AttackModule

var heroStats := HeroStats.new()
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

func _process(delta):
	## just for testing
	velocity = Vector2(1,0) * 20
	move_and_slide()


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
	if area.owner is NPC:
		var npc = area.owner
		isWithNPC = true
		var shouldAttack = _shouldAttackNPC(npc)
		if shouldAttack:
			npc.getsAttacked()
			isWithNPC = false ## just for now, then later we would need to wait for an animation or dialogue
		else:
			var shouldGetReward = _shouldGetReward(npc)
			print(shouldGetReward)
			if shouldGetReward:
				npc.givesReward()
				isWithNPC = false ## just for now, then later we would need to wait for an animation or dialogue
			else:
				isWithNPC = false ## just for now, then later we would need to wait for an animation or dialogue

func _on_attack_module_area_exited(area):
	if area.owner is Enemy:
		var enemy = area.owner
		if enemiesDetected.has(enemy):
			var oldEnemies = enemiesDetected.duplicate()
			oldEnemies.erase(enemy)
			enemiesDetected = oldEnemies
