extends PassiveSkill

class_name CounterMagic
var currentStatus: StatusEffect = null
var skillData: PassiveSkillData = load("res://resources/skills/passive skills/CounterMagic.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onEvadeStats.append(self.skillTriggers[0])
	learner.onTurnStart.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onTurnStart.erase(self.skillTriggers[0])
	learner.onEvadeStats.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	if(currentStatus != null):
		print("Vindo aqui")
		digimon.enemy.applyStatus(currentStatus)
