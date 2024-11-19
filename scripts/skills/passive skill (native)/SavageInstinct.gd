extends PassiveSkill

class_name SavageInstinct

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/GrowlmonPassive.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onBattleStart.append(self.skillTriggers[0])
	learner.onGetDamage.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onBattleStart.erase(self.skillTriggers[0])
	learner.onGetDamage.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	digimon.applyStatus(Adrenaline.new())
