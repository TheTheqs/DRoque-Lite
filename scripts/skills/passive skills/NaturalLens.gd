extends PassiveSkill

class_name NaturalLens

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/NaturalLens.tres")
func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onBattleStart.append(self.skillTriggers[0])
	learner.onGettingStats.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onBattleStart.erase(self.skillTriggers[0])
	learner.onGettingStats.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	var precisionBuff: Precision = Precision.new()
	digimon.applyStatus(precisionBuff)
