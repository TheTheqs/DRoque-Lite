extends PassiveSkill

class_name AvengersPact

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/MonodramonPassive.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onChange.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onChange.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	digimon.getActions(1)
