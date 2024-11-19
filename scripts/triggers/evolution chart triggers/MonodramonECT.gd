extends Trigger

class_name MonodramonECT
var relatedEC: EvolutionChart

func _init(newEC: EvolutionChart) -> void:
	self.relatedEC = newEC

func checkContext(digimon: Digimon, context) -> bool:
	if(digimon.currentLevel >= 15 and context is DamageSkill and context.element == Enums.Element.EARTH and digimon.onChanging != false):
		relatedEC.activateEvolution(0)
	return false
