extends DamageSkill

class_name KnucklePunch
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/KnucklePunch.tres")

func _init():
	setStats(skillData)
