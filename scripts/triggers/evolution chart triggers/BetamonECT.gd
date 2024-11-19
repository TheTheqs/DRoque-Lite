extends Trigger

class_name BetamonECT
var relatedEC: EvolutionChart

func _init(newEC: EvolutionChart) -> void:
	self.relatedEC = newEC

func checkContext(digimon: Digimon, context) -> bool:
	if(digimon.currentLevel >= 15 and context is DamageSkill and context.element == Enums.Element.WATER and digimon.baseINT < digimon.bonusINT):
		relatedEC.activateEvolution(0)
	return false
