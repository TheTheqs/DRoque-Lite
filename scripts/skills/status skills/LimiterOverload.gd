extends StatusSkill

class_name LimiterOverload
var stats: StatusSkillData = load("res://resources/skills/status skills/LimiterOverload.tres")

func _init() ->void:
	setStats(stats)
	self.isSlow = true
	self.statusEffects.append(Slow.new())

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.enemy.statusEffect.has(1)):
		priority += 5

func skillSingularity(digimon: Digimon) -> void:
	if(digimon.enemy.statusEffect.has(1)):
		self.statusEffects[0].schance = -1
