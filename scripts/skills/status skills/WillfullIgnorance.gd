extends StatusSkill

class_name WillfullIgnorance
var stats: StatusSkillData = load("res://resources/skills/status skills/WillfullIgnorance.tres")

func _init() ->void:
	setStats(stats)
	self.statusEffects.append(Blind.new())

func priorityCheck(digimon: Digimon) -> void:
	if(Util.getProportion(digimon.currentHealth, digimon.maxHelth) > 0.7):
		priority += 1
