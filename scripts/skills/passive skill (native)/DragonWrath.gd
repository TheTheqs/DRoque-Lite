extends PassiveSkill

class_name DragonWrath

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/ExVeemonPassive.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onBattleStart.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onBattleStart.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	var strBonus: int = max(1, round(digimon.getAttribute("str")*0.30))
	digimon.applyStatus(StrPlus.new(strBonus))
