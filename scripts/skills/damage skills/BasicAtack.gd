extends DamageSkill

class_name BasicAtack
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/BasicAtack.tres")

func _init():
	setStats(skillData)

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.currentMana == 0):
		priority += 2
	if(digimon.digimonLearnedSkills.has(29) and digimon.tamer.actions > 1):
		priority += 4
