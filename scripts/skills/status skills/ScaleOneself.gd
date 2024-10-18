extends StatusSkill

class_name ScaleOneself
var stats: StatusSkillData = load("res://resources/skills/status skills/ScaleOneself.tres")

func _init() ->void:
	setStats(stats)
	self.statusEffects.append(Reflect.new(15))

func priorityCheck(digimon: Digimon) -> void:
	if(Util.getProportion(digimon.currentHealth, digimon.maxHelth) > 0.7):
		priority += 1
