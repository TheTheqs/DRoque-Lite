extends PassiveSkill

class_name MarkingDodge
var markStatus: Mark = Mark.new()
var skillData: PassiveSkillData = load("res://resources/skills/passive skills/MarkingDodge.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onEvadeDamage.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onEvadeDamage.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	digimon.enemy.applyStatus(markStatus)
