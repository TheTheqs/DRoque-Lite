extends StatusSkill

class_name RegenCure
var stats: StatusSkillData = load("res://resources/skills/pseudo skills/RegenCure.tres")

func _init() ->void:
	setStats(stats)
	statusEffects.append(Heal.new(0.0, false))
	self.needsAnimation = false

func skillSingularity(digimon: Digimon) -> void:
	statusEffects[0].healValue = Util.cap(digimon.maxHelth*0.1)

func priorityCheck(_digimon: Digimon) -> void:
	priority = 0
