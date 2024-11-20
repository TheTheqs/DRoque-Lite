extends DamageSkill

class_name SpikingStrike
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/SpikingStrike.tres")

func _init():
	setStats(skillData)

func skillSingularity(_digimon: Digimon) -> void:
	if(Util.chance(20)):
		self.damageType = Enums.DamageType.TRUE
	else:
		self.damageType = Enums.DamageType.PHYSICAL
