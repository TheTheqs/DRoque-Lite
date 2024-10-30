extends PassiveSkill

class_name Counting
var skillData: PassiveSkillData = load("res://resources/skills/passive skills/Counting.tres")
var intBonus: IntPlus = IntPlus.new(1)
func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onTurnStart.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onTurnStart.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
		digimon.applyStatus(intBonus.getStatus())
