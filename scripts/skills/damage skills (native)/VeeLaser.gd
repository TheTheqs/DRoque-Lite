extends DamageSkill

class_name VeeLaser
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/VeeLaser.tres")

func _init():
	setStats(skillData)
