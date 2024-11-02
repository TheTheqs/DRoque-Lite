extends StatusSkill

class_name CureI
var stats: StatusSkillData = load("res://resources/skills/status skills/CureI.tres")

func _init() ->void:
	setStats(stats)
	statusEffects.append(Heal.new(0.0, false))

func skillSingularity(digimon: Digimon) -> void:
	statusEffects[0].healValue = Util.cap(digimon.maxHelth*0.2)

func priorityCheck(digimon: Digimon) -> void:
	var healthProp: float = Util.getProportion(digimon.currentHealth, digimon.maxHelth) * 100.0
	var thresholds = [80, 60, 40, 20]
	var increments = [1, 1, 1, 2]
	for i in range(thresholds.size()):
		if healthProp <= thresholds[i]:
			priority += increments[i]
	if(healthProp > 80):
		priority = 0
