extends PassiveSkill

class_name BackwaterCamp

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/PaildramonPassive.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onDamageCalc.append(self.skillTriggers[0])
	learner.onGetDamage.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onDamageCalc.erase(self.skillTriggers[0])
	learner.onGetDamage.erase(self.skillTriggers[0])
