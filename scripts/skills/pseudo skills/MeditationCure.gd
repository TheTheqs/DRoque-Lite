extends StatusSkill

class_name MeditationCure
var stats: StatusSkillData = load("res://resources/skills/pseudo skills/MeditationCure.tres")

func _init() ->void:
	setStats(stats)
	statusEffects.append(Heal.new(0.0, true))
	self.needsAnimation = false

func skillSingularity(digimon: Digimon) -> void:
	statusEffects[0].healValue = Util.cap(digimon.maxMana*0.1)

func priorityCheck(_digimon: Digimon) -> void:
	priority = 0
