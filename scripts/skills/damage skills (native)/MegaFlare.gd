extends DamageSkill

class_name MegaFlare
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/MegaFlare.tres")

func _init():
	setStats(skillData)

func skillSingularity(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(2)):
		self.damageValue *= 1.5
		digimon.unapplyStatus(digimon.statusEffect[2])

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(2)):
		priority += 3
