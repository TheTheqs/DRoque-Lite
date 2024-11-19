extends Trigger

class_name GuilmonECT
var relatedEC: EvolutionChart

func _init(newEC: EvolutionChart) -> void:
	self.relatedEC = newEC

func checkContext(digimon: Digimon, context) -> bool:
	if(digimon.currentLevel >= 15 and digimon.statusEffect.has(31) and Util.getProportion(digimon.currentHealth, digimon.maxHelth) <= 0.6 and context is String and context == "Changing"):
		relatedEC.activateEvolution(0)
	return false
