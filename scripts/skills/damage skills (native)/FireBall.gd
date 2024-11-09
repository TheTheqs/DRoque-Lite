extends DamageSkill

class_name FireBall
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/FireBall.tres")

func _init():
	setStats(skillData)
