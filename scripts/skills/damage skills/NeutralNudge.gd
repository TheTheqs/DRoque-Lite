extends DamageSkill

class_name NeutralNudge
var skillData: DamageSkillData = load("res://resources/skills/NeutralNudge.tres")
#Dicionário para cálculo de dano adicional
var ratioDick: Dictionary = {
	Enums.Tier.ROOKIE : 1.0,
	Enums.Tier.CHAMPION : 1.2,
	Enums.Tier.ULTIMATE : 1.4,
	Enums.Tier.MEGA : 1.6
}
func _init():
	setStats(skillData)

func priorityCheck(digimon: Digimon) -> void:
	priority = staticPriority
	if(digimon.currentMana == 0):
		priority += 2

func skillSingularity(digimon: Digimon) -> void:
	self.damageValue *= ratioDick[digimon.digimonTier]
