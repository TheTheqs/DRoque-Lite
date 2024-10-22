extends PassiveSkill

class_name EfficientCasting

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/EfficientCasting.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onManaConsumption.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onManaConsumption.erase(self.skillTriggers[0])
