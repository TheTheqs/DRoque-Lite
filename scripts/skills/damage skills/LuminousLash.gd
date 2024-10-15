extends DamageSkill

class_name LuminousLash
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/LuminousLash.tres")

func _init():
	setStats(skillData)

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.LIGHT):
		priority += 3

func skillSingularity(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.LIGHT):
		digimon.getActions(1)
