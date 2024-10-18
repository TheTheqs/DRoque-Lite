extends PassiveSkill

class_name EmergencySupplies

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/EmergencySupplies.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onBattleStart.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onBattleStart.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	var healValue: float = Util.cap(digimon.maxHelth*0.3)
	digimon.heal(healValue, false)
