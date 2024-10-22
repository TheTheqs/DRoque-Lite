extends PassiveSkill

class_name SlowAntibodies

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/SlowAntibodies.tres")
func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onBattleStart.append(self.skillTriggers[0])
	learner.onPassingTurn.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onBattleStart.erase(self.skillTriggers[0])
	learner.onPassingTurn.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(0)):
		digimon.unapplyStatus(0)
