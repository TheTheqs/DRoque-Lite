extends StatusSkill

class_name LimiterRemoval
var stats: StatusSkillData = load("res://resources/skills/status skills/LimiterRemoval.tres")

func _init() ->void:
	setStats(stats)
	self.statusEffects.append(Haste.new(3))

func priorityCheck(digimon: Digimon) -> void:
	if(Util.getProportion(digimon.currentHealth, digimon.maxHelth) > 0.7):
		priority += 1
