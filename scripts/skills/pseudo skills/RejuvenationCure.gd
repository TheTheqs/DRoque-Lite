extends StatusSkill

class_name RejuvenationCure
var stats: StatusSkillData = load("res://resources/skills/pseudo skills/RejuvenationCure.tres")

func _init() ->void:
	setStats(stats)
	statusEffects.append(Heal.new(0.0, false))
	statusEffects.append(Heal.new(0.0, true))
	self.needsAnimation = false

func skillSingularity(digimon: Digimon) -> void:
	statusEffects[0].healValue = Util.cap(digimon.maxHelth*0.2)
	statusEffects[1].healValue = Util.cap(digimon.maxMana*0.2)

func priorityCheck(_digimon: Digimon) -> void:
	priority = 0
