extends DamageSkill

class_name PepperBreath
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/PepperBreath.tres")

func _init():
	setStats(skillData)
