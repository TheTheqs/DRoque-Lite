extends StatusSkill

class_name DimensionalBarrier
var stats: StatusSkillData = load("res://resources/skills/status skills/DimensionalBarrier.tres")

func _init() ->void:
	setStats(stats)
	self.statusEffects.append(Barrier.new(2))

func priorityCheck(digimon: Digimon) -> void:
	if(Util.getProportion(digimon.currentHealth, digimon.maxHelth) < 0.40):
		priority += 3
