extends StatusSkill

class_name PumpItUp
var stats: StatusSkillData = load("res://resources/skills/status skills/PumpItUp.tres")

func _init() ->void:
	setStats(stats)
	self.statusEffects.append(Bravery.new(1))

func skillSingularity(digimon: Digimon) -> void:
	self.statusEffects[0].stacks = 1
	if(digimon.getAttribute("str") < digimon.enemy.getAttribute("str")):
		self.statusEffects[0].stacks = 2
