extends PassiveSkill

class_name DragonGrumble

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/VeemonPassive.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onBattleStart.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onBattleStart.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	var strBonus: int = max(1, round(digimon.getAttribute("str")*0.15))
	digimon.applyStatus(StrPlus.new(strBonus))
