extends PassiveSkill

class_name SupplySquad

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/SupplySquad.tres")
func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onBattleStart.append(self.skillTriggers[0])
	learner.onActing.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onBattleStart.erase(self.skillTriggers[0])
	learner.onActing.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	var healValue: float = Util.cap(digimon.maxHelth*0.4)
	digimon.heal(healValue, false)
	var nonStop: Unstoppable = Unstoppable.new(2)
	digimon.applyStatus(nonStop)
