extends PassiveSkill

class_name NaturalSpirit
var prioritiesChange: Array[DamageSkill] = []
var skillData: PassiveSkillData = load("res://resources/skills/passive skills/WormmonPassive.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onDamageCalc.append(self.skillTriggers[0])
	learner.onLearnSkill.append(self.skillTriggers[0])
	for skill: Skill in learner.digimonSkills:
		if (skill != null and skill is DamageSkill and skill.element == Enums.Element.PLANT):
			skill.bonusPriority += 1
			prioritiesChange.append(skill)
	return true

func unlearn(learner: Digimon) -> void:
	learner.onDamageCalc.erase(self.skillTriggers[0])
	learner.onLearnSkill.erase(self.skillTriggers[0])
	for damageSkill: DamageSkill in prioritiesChange:
		damageSkill.bonusPriority -= 1
	prioritiesChange.clear()
