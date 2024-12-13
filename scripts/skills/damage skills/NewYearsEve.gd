extends DamageSkill

class_name NewsYearEve
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/NewYearsEve.tres")
#dicionário de elementos para mudança dinâmica do mesmo
var elementDic: Dictionary = {
	0 : Enums.Element.FIRE,
	1 : Enums.Element.THUNDER,
	2 : Enums.Element.LIGHT,
	3 : Enums.Element.NEUTRAL
}
func _init():
	self.isGlobal = true #a declaração de skill global deve estar no init do script, e não no recurso.
	setStats(skillData)

#função de cálculo de prioridade
func priorityCheck(_digimon: Digimon) -> void:
	priority += 1
	
#função que muda o elemento dessa habilidade, uma singularidade sua
func skillSingularity(_digimon: Digimon) -> void:
	self.element = self.elementDic[Util.random(0, 3)]
