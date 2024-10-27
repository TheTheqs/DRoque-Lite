extends DamageSkill

class_name BackupStrike
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/BackupStrike.tres")
var skillTrigger: BackupStrikeTrigger = BackupStrikeTrigger.new(self)
func _init():
	setStats(skillData)

func priorityCheck(_digimon: Digimon) -> void:
	if(skillTrigger.basicAtackUsed == true):
		priority += 4

func learn(learner: Digimon, index: int) -> bool:
	learner.digimonSkills[index] = self
	learner.onActing.append(skillTrigger)
	learner.onTurnEnd.append(skillTrigger)
	return true

func unlearn(unlearner: Digimon) -> void:
	unlearner.onActing.erase(skillTrigger)
	unlearner.onTurnEnd.erase(skillTrigger)
	pass
