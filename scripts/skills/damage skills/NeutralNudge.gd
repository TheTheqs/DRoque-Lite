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
#dicionário para cálculo de prioridade
var priorityDick: Dictionary = {
	Enums.Tier.ROOKIE : 0,
	Enums.Tier.CHAMPION : 1,
	Enums.Tier.ULTIMATE : 2,
	Enums.Tier.MEGA : 3
}
func _init():
	setStats(skillData)

#função de cálculo de prioridade
func priorityCheck(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.NEUTRAL):
		priority += 2
	priority += priorityDick[digimon.digimonTier]
	
#função para cálculo de dano adicional baseado no tier do digimon, algo "singular" dessa habilidade
func skillSingularity(digimon: Digimon) -> void:
	self.damageValue *= ratioDick[digimon.digimonTier]

#sobreposição da froma de calcular o CD, pois essa habilidade zera seu CD em Digimons Neutros.
func applyCooldown(digimon: Digimon) -> void:
	if(digimon.element ==  Enums.Element.NEUTRAL):
		currentCooldown = 0
	else:
		currentCooldown = cooldowm
		if(currentCooldown > 0):
			usable = false
