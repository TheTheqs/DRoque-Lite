extends StatusSkill
#Essa é uma pseudo habilidade, significa que ela nao vai ser usada diretamente, e sim pelo efeito secundário de outra habilidade ou trigger.
class_name LifeStealHeal
var skillData: StatusSkillData = load("res://resources/skills/pseudo skills/LifeStealHeal.tres")
var healValue: float = 0

func _init() -> void:
	setStats(skillData)
	self.needsAnimation = false
	statusEffects.append(Heal.new(0.0, false))

func skillSingularity(_digimon: Digimon) -> void:
	statusEffects[0].healValue = Util.cap(healValue)

func priorityCheck(_digimon: Digimon) -> void:
	priority = 0
