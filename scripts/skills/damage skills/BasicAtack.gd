extends DamageSkill

class_name BasicAtack
var skillData: DamageSkillData = load("res://resources/skills/BasicAtack.tres")

func _init():
	setStats(skillData)

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.currentMana == 0):
		priority += 2
