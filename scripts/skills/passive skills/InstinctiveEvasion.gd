extends PassiveSkill

class_name InstinctiveEvasion

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/InstinctiveEvasion.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onGetDamage.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onGetDamage.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	digimon.applyStatus(Evade.new())
