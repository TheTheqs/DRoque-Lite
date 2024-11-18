extends Trigger

class_name AgumonECT
var relatedEC: EvolutionChart
var evCount0: int

func _init(newEC: EvolutionChart) -> void:
	self.relatedEC = newEC

func checkContext(digimon: Digimon, context) -> bool:
	if(digimon.currentLevel >= 15 and context is PepperBreath and digimon.statusEffect.has(2)):
		evCount0 += 1
		if(evCount0 >= 3):
			relatedEC.activateEvolution(0)
	return false
