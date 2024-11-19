extends PassiveSkill

class_name SharpenedEdge

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/DorugamonPassive.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onCriticalCalc.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onCriticalCalc.erase(self.skillTriggers[0])
