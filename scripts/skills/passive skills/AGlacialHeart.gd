extends PassiveSkill

class_name AGlacialHeart

var skillData: PassiveSkillData = load("res://resources/skills/passive skills/AGlacialHeart.tres")
var newUnstoppable: Unstoppable = Unstoppable.new(3)
func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onGettingStats.append(self.skillTriggers[0])
	learner.onUnapplyStatus.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onGettingStats.erase(self.skillTriggers[0])
	learner.onUnapplyStatus.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	digimon.applyStatus(newUnstoppable)
