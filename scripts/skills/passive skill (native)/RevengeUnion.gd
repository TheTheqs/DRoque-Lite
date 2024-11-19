extends PassiveSkill

class_name RevengeUnion

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/StrikedramonPassive.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onChange.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onChange.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	digimon.getActions(1)
