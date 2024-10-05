extends DamageSkill

class_name BasicAtack
var skillData: DamageSkillData = preload("res://resources/skills/BasicAtack.tres")

func _init():
	setStats(skillData)
