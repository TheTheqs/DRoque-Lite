extends DamageSkill

class_name ShadowSlice
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/ShadowSlice.tres")

func _init():
	setStats(skillData)

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.DARK):
		priority += 3

func skillSingularity(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.DARK):
		digimon.getActions(1)
