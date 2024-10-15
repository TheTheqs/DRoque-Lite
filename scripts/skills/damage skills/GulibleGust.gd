extends DamageSkill

class_name GulibleGust
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/GulibleGust.tres")
var secondAtack : GulibleGust2 = GulibleGust2.new()

func _init():
	setStats(skillData)

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.WIND):
		priority += 2

func skillSingularity(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.WIND):
		digimon.actionsToGo.append(secondAtack)
