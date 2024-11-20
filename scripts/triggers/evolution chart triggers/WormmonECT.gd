extends Trigger

class_name WormmonECT
var relatedEC: EvolutionChart

func _init(newEC: EvolutionChart) -> void:
	self.relatedEC = newEC

func checkContext(digimon: Digimon, context) -> bool:
	if(digimon.currentLevel >= 15 and context == "TurnStart" and (Util.getProportion(digimon.baseAGI, digimon.bonusAGI) <= 0.5)):
		relatedEC.activateEvolution(0)
	return false
