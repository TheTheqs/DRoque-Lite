extends PassiveSkill

class_name ForceOfHabit

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/ForceOfHabit.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onGotTargeted.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onGotTargeted.erase(self.skillTriggers[0])
