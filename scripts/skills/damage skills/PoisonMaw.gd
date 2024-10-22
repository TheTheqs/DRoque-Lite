extends DamageSkill

class_name PoisonMaw
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/PoisonMaw.tres")

func _init():
	setStats(skillData)
	self.statusEffects.append(Poison.new())

func priorityCheck(digimon: Digimon) -> void:
	if(Util.getProportion(digimon.enemy.currentHealth, digimon.enemy.maxHelth) <= 0.8):
		priority += 1

func applyStats(digimon: Digimon) -> void:
	var newPoison: Poison = self.statusEffects[0].getStatus()
	digimon.applyStatus(newPoison)
