extends DamageSkill

class_name VeemonHeadbutt
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/VeemonHeadbutt.tres")

func _init():
	setStats(skillData)

func skillSingularity(digimon: Digimon) -> void:
	var bonusDamage: float = 1.0 + digimon.getAttribute("wis")*0.005
	self.damageValue *= max(1, bonusDamage)
