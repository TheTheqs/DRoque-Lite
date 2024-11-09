extends PassiveSkill

class_name MysticalScale

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/BetamonPassine.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onBattleStart.append(self.skillTriggers[0])
	learner.onBeforeGettingStats.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onBattleStart.erase(self.skillTriggers[0])
	learner.onBeforeGettingStats.append(self.skillTriggers[0])
