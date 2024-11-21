extends ItemEffect

class_name UpgradeIEffect

func itemEffect(digimon: Digimon) -> void:
	if(Util.checkArray(digimon.possibleEvolution) and digimon.digimonTier == Enums.Tier.ROOKIE and digimon.currentLevel >= 15):
		digimon.Evolve(digimon.possibleEvolution[0])
		if(digimon.tamer is Enemy):
			digimon.tamer.actions += 1
	else:
		digimon.tamer.showContent(tr(StringName("Fail")))

func priorityCalc(digimon: Digimon) -> int:
	var priority: int = 0
	if(Util.checkArray(digimon.possibleEvolution)):
		priority += Util.random(10, 20)
	return priority
