extends DamageSkill

class_name ElectricShock
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/ElectricShock.tres")

func _init():
	setStats(skillData)
	self.isSlow = true

func skillSingularity(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(31)):
		self.damageValue *= 2

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(31)):
		priority += 3
