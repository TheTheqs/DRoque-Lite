extends StatusSkill

class_name TrueVision
var stats: StatusSkillData = load("res://resources/skills/status skills/TrueVision.tres")

func _init() ->void:
	setStats(stats)
	self.statusEffects.append(Focus.new())

func priorityCheck(digimon: Digimon) -> void:
	if(Util.getProportion(digimon.currentHealth, digimon.maxHelth) > 0.7):
		priority += 1
	if(digimon.getAttribute("dex") >= 100):
		priority = 0
