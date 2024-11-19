extends Trigger

class_name DorumonECT
var relatedEC: EvolutionChart

func _init(newEC: EvolutionChart) -> void:
	self.relatedEC = newEC

func checkContext(digimon: Digimon, context) -> bool:
	if(digimon.currentLevel >= 15 and context is DamageData and context.damageElement == Enums.Element.EARTH and digimon.enemy.armory[0] == null):
		relatedEC.activateEvolution(0)
	return false
